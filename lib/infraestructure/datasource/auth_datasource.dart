import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/auth/login/login_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/auth/login/login_response.dart';
import 'package:routines_gym_app/configuration/constants/app_constants.dart';
import 'package:routines_gym_app/infraestructure/datasource/user_datasource.dart';
import 'package:routines_gym_app/transversal/common/response_codes.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class AuthDatasource {

  final Dio dio = Dio();
  late final GoogleSignIn googleSignIn;
  final UserDatasource userDatasource =UserDatasource();
  
  Future<LoginResponse> login(LoginRequest request) async {
    LoginResponse response = LoginResponse();
    try {
      dynamic apiResponse = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.authEndpoint}/login',
        data: {
          'userEmail': request.userEmail,
          'userPassword': request.userPassword,
        },
      );

      Map<String, dynamic> data = apiResponse.data as Map<String, dynamic>;
      if (data['responseCode'] == ResponseCodes.ok) {
        response.isSuccess = data['isSuccess'];
        response.message = data['message'];
        response.bearerToken = data['bearerToken'];
        response.isAdmin = data['isAdmin'] ?? false;
      } else {
        response.isSuccess = false;
        response.message = data['message'] ?? 'Error: ${apiResponse.statusMessage}';
      }
    } catch (ex) {
      response.isSuccess = false;
      response.message = 'unexpected error on AuthDatasource -> login: ${ex.toString()}';
      ToastMessage.showToast("Error during login");
    }
    return response;
  }

  // Future<Object> signInWithGoogle() async {
  //   try {
  //     await googleSignIn.signOut(); 
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      
  //     if (googleUser == null) {
  //       ToastMessage.showToast('No se seleccionó ninguna cuenta de Google.');
  //       return false;
  //     }

  //     bool userCreated = false;

  //     String dni = "";
  //     String username = googleUser.displayName ?? 'Usuario Google';
  //     String surname = "";
  //     String email = googleUser.email;
  //     String password = googleUser.email;
  //     String confirmPassword = googleUser.email;

  //     LoginRequest loginRequest = LoginRequest(
  //       userPassword: googleUser.password, 
  //       userEmail: googleUser.email
  //     );

  //     LoginResponse loginResult = await login(loginRequest); 
  //     if (loginResult is bool) {
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

  //     if (loginResult is Map<String, dynamic> && loginResult.isSuccess) {
  //       GetUserByEmailRequest getUserByEmailRequest = GetUserByEmailRequest(
  //         email: email
  //       );

  //       GetUserByEmailResponse getUserByEmailResponse = await userDatasource.getUserByEmail(getUserByEmailRequest);
  //       if (getUserByEmailResponse != null) {
  //         if (userCreated) {
  //           ToastMessage.showToast(
  //             'Se te ha enviado un correo a tu Gmail. Por su seguridad, siga las instrucciones.'
  //           );
  //         }

  //         loginResult["user"] = user.toJson(); 
  //         return loginResult;
  //       }
  //       return loginResult;
  //     }

  //     return loginResult;
  //   } catch (_) {
  //     ToastMessage.showToast('No se pudo iniciar sesión con Google.');
  //     return false;
  //   }
  // }

  // Future<bool> isValidToken(IsValidTokenRequest isValidTokenRequest) async {
  //   try {
  //     var response = await dio.post(
  //       '${ApiConstants.baseUrl}${ApiConstants.authEndpoint}/check-token-status',
  //       data: {
  //         'token': isValidTokenRequest.token
  //       },
  //     );
  //     return response.data['isValid'] == true;
  //   } catch (_) {
  //     ToastMessage.showToast('No se pudo validar la sesión.');
  //     return false;
  //   }
  // }
}