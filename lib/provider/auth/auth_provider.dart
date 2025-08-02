import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/auth/check_token_status/check_token_status_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/auth/check_token_status/check_token_status_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/auth/login/login_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/auth/login/login_response.dart';
import 'package:routines_gym_app/infraestructure/repository/auth_repository.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool isLoggedIn = false;
  bool isChecking = false;

  Future<void> init() async {
    isChecking = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      CheckTokenStatusRequest checkTokenStatusRequest = CheckTokenStatusRequest(
        token: prefs.getString('token') ?? ''
      );

      CheckTokenStatusResponse checkTokenStatusResponse = await _authRepository.checkTokenStatus(checkTokenStatusRequest);
      isLoggedIn = checkTokenStatusResponse.isValid;

      if (!isLoggedIn) {
        await prefs.clear();
      }
      //isLoggedIn = false;
    } catch (ex) {
      isLoggedIn = false;
      ToastMessage.showToast('Unexpected error on checkTokenStatus');
    } finally {
      isChecking = false;
      notifyListeners();
    }
  }

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    LoginResponse loginResponse = LoginResponse();

    try {
      loginResponse = await _authRepository.login(loginRequest);

      if (loginResponse.isSuccess) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', loginResponse.bearerToken);
        await prefs.setString('userEmail', loginRequest.userEmail);
        await prefs.setBool('isAdmin', loginResponse.isAdmin!);

        isLoggedIn = true;
        notifyListeners();
      }
    } catch (ex) {
      loginResponse.isSuccess = false;
      loginResponse.message = 'Unexpected error on login: ${ex.toString()}';
      ToastMessage.showToast('Unexpected error');
    }

    return loginResponse;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    isLoggedIn = false;
    notifyListeners();
  }
}