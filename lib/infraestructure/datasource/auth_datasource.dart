// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/auth/check_token_status/check_token_status_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/auth/login/login_request.dart';
import 'package:routines_gym_app/configuration/constants/app_constants.dart';
import 'package:routines_gym_app/infraestructure/datasource/user_datasource.dart';

class AuthDatasource {
  final Dio dio = Dio();
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  final UserDatasource userDatasource = UserDatasource();

  Future<Map<String, dynamic>> login(LoginRequest loginRequest) async {
    Map<String, dynamic> data = {};
    try
    {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.authEndpoint}/login',
        data: {
          'userEmail': loginRequest.userEmail,
          'userPassword': loginRequest.userPassword,
        },
      );

      data = response.data as Map<String, dynamic>;
    }
    catch (ex)
    {
      print('unexpected error on AuthDatasource -> login: ${ex.toString()}');
    }

    return data;
  }

  Future<Map<String, dynamic>> checkTokenStatus(CheckTokenStatusRequest checkTokenStatusRequest) async 
  {
    Map<String, dynamic> data = {};
    try
    {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.authEndpoint}/check-token-status',
        data: {
          'token': checkTokenStatusRequest.token,
        },
      );

      data = response.data as Map<String, dynamic>;
    }
    catch (ex)
    {
      print('unexpected error on AuthDatasource -> checkTokenStatus: ${ex.toString()}');
    }

    return data;
  }

  // Future<Object> signInWithGoogle() async {
  //   try {
  //     await googleSignIn.signOut();
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  //     if (googleUser == null) {
  //       ToastMessage.showToast('No se seleccionó ninguna cuenta de Google.');
  //       return false;
  //     }

  //     String dni = "";
  //     String username = googleUser.displayName ?? 'Usuario Google';
  //     String surname = "";
  //     String email = googleUser.email;
  //     String password = googleUser.id; // Usar el id como password temporal
  //     String confirmPassword = googleUser.id;

  //     // Intentar login con email y password temporal
  //     LoginRequest loginRequest = LoginRequest(
  //       userEmail: email,
  //       userPassword: password,
  //     );

  //     LoginResponse loginResult = await login(loginRequest);
  //     bool userCreated = false;

  //     // Si el login falla, crear el usuario y volver a intentar login
  //     if (!loginResult.isSuccess) {
  //       CreateGoogleUserRequest createGoogleUserRequest = CreateGoogleUserRequest(
  //         dni: dni,
  //         username: username,
  //         surname: surname,
  //         email: email,
  //         password: password,
  //         confirmPassword: confirmPassword,
  //       );
  //       await userDatasource.createGoolgeUser(createGoogleUserRequest);
  //       userCreated = true;
  //       loginResult = await login(loginRequest);
  //     }

  //     if (loginResult.isSuccess) {
  //       // Obtener el usuario por email
  //       GetUserByEmailRequest getUserByEmailRequest = GetUserByEmailRequest(email: email);
  //       GetUserByEmailResponse? getUserByEmailResponse = await userDatasource.getUserByEmail(getUserByEmailRequest);
  //       if (userCreated) {
  //         ToastMessage.showToast(
  //           'Se te ha enviado un correo a tu Gmail. Por su seguridad, siga las instrucciones.'
  //         );
  //       }
  //       // Retornar loginResult y el usuario
  //       return {
  //         "loginResult": loginResult,
  //         "user": getUserByEmailResponse.userDTO?.toJson(),
  //       };
  //     }

  //     return loginResult;
  //   } catch (_) {
  //     ToastMessage.showToast('No se pudo iniciar sesión con Google.');
  //     return false;
  //   }
  // }
}