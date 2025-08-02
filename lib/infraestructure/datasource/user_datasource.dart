import 'package:dio/dio.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/change_password_with_password_and_email/change_password_with_password_and_email_reqeust.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_admin/create_admin_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_google_user/create_google_user_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_new_password/create_new_password_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_user/create_user_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/delete_user/delete_user_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/get/get_user_by_email/get_user_by_email_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/update_user/update_user_request.dart';
import 'package:routines_gym_app/configuration/constants/app_constants.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class UserDatasource {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> getUsers() async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/get-users',
      );
      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      ToastMessage.showToast("unexpected error");
    }
    return data;
  }

  Future<Map<String, dynamic>> getUserByEmail(GetUserByEmailRequest request) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/get-user-by-email',
        data: {
          'email': request.email,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      ToastMessage.showToast("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> createUser(CreateUserRequest request) async {
    Map<String, dynamic> data = {};
    try {
      request.dni = "12345678A";
      request.username = "a";
      request.email = "a@a.a";
      request.password = "123456Aa!";
      request.confirmPassword = "123456Aa!";

      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/create-user',
        data: {
          'dni': request.dni,
          'username': request.username,
          'email': request.email,
          'password': request.password,
          'confirmPassword': request.confirmPassword,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      ToastMessage.showToast("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> createGoolgeUser(CreateGoogleUserRequest request) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/create-google-user',
        data: {
          'dni': request.dni,
          'username': request.username,
          'surname': request.surname,
          'email': request.email,
          'password': request.password,
          'confirmPassword': request.confirmPassword,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      ToastMessage.showToast("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> createAdmin(CreateAdminRequest request) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/create-admin',
        data: {
          'dni': request.dni,
          'username': request.username,
          'surname': request.surname,
          'email': request.email,
          'password': request.password,
          'confirmPassword': request.confirmPassword,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      ToastMessage.showToast("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> updateUser(UpdateUserRequest request) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/update-user',
        data: {
          'originalEmail': request.originalEmail,
          'dniToBeFound': request.dniToBeFound,
          'username': request.username,
          'surname': request.surname,
          'email': request.email,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      ToastMessage.showToast("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> deleteUser(DeleteUserRequest request) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/delete-user',
        data: {
          'email': request.email,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      ToastMessage.showToast("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> createNewPassword(CreateNewPasswordRequest request) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/create-new-password',
        data: {
          'userEmail': request.userEmail,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      ToastMessage.showToast("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> changePasswordWithPasswordAndEmail(ChangePasswordWithPasswordAndEmailRequest request) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/change-password-with-password-and-email',
        data: {
          'userEmail': request.userEmail,
          'oldPassword': request.oldPassword,
          'newPassword': request.newPassword,
          'confirmNewPassword': request.confirmNewPassword,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      ToastMessage.showToast("unexpected error");
    }
    
    return data;
  }
}