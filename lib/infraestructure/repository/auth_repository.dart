import 'package:routines_gym_app/application/data_transfer_object/interchange/auth/check_token_status/check_token_status_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/auth/check_token_status/check_token_status_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/auth/login/login_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/auth/login/login_response.dart';
import 'package:routines_gym_app/infraestructure/datasource/auth_datasource.dart';

class AuthRepository {

  final AuthDatasource authDatasource = AuthDatasource();

  Future<LoginResponse> login(LoginRequest loginRequest) async 
  {
    LoginResponse loginResponse = LoginResponse();
    try
    {
      Map<String, dynamic> data = await authDatasource.login(loginRequest);
      if (data['responseCodeJson'] == 200) {        
        loginResponse.responseCode = data['responseCode'];
        loginResponse.isSuccess = data['isSuccess'];
        loginResponse.message = data['message'];
        loginResponse.isAdmin = data['isAdmin'];
        loginResponse.bearerToken = data['bearerToken'];
      } else {
        loginResponse.isSuccess = false;
        loginResponse.message = 'Error during login';
      }   
    }
    catch (ex) 
    {
      loginResponse.isSuccess = false;
      loginResponse.message = 'unexpected error on AuthRepository -> login';
    }

    return loginResponse;
  }

  Future<CheckTokenStatusResponse> checkTokenStatus(CheckTokenStatusRequest checkTokenStatusRequest) async
  {
    CheckTokenStatusResponse checkTokenStatusResponse = CheckTokenStatusResponse();
    try
    {
      Map<String, dynamic> data = await authDatasource.checkTokenStatus(checkTokenStatusRequest);
      if (data['responseCodeJson'] == 200) {
        checkTokenStatusResponse.responseCode = data['responseCode'];
        checkTokenStatusResponse.isSuccess = data['isSuccess'];
        checkTokenStatusResponse.isValid = data['isValid'];
        checkTokenStatusResponse.message = data['message'];
      } else {
        checkTokenStatusResponse.isSuccess = false;
        checkTokenStatusResponse.message = 'Error checking token status';
      }
    }
    catch (ex) 
    {
      checkTokenStatusResponse.isSuccess = false;
      checkTokenStatusResponse.message = 'unexpected error on AuthRepository -> checkTokenStatus';
    }

    return checkTokenStatusResponse;
  }
}