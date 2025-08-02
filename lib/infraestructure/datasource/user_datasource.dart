// ignore_for_file: avoid_print

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
      print("unexpected error");
    }
    return data;
  }

  Future<Map<String, dynamic>> getUserByEmail(GetUserByEmailRequest getUserByEmailRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/get-user-by-email',
        data: {
          'email': getUserByEmailRequest.email,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> createUser(CreateUserRequest createUserRequest) async {
    Map<String, dynamic> data = {};
    try {
      createUserRequest.dni = "12345678A";
      createUserRequest.username = "a";
      createUserRequest.email = "a@a.a";
      createUserRequest.password = "123456Aa!";
      createUserRequest.confirmPassword = "123456Aa!";

      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/create-user',
        data: {
          'dni': createUserRequest.dni,
          'username': createUserRequest.username,
          'email': createUserRequest.email,
          'password': createUserRequest.password,
          'confirmPassword': createUserRequest.confirmPassword,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> createGoolgeUser(CreateGoogleUserRequest createGoogleUserRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/create-google-user',
        data: {
          'dni': createGoogleUserRequest.dni,
          'username': createGoogleUserRequest.username,
          'surname': createGoogleUserRequest.surname,
          'email': createGoogleUserRequest.email,
          'password': createGoogleUserRequest.password,
          'confirmPassword': createGoogleUserRequest.confirmPassword,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> createAdmin(CreateAdminRequest createAdminRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/create-admin',
        data: {
          'dni': createAdminRequest.dni,
          'username': createAdminRequest.username,
          'surname': createAdminRequest.surname,
          'email': createAdminRequest.email,
          'password': createAdminRequest.password,
          'confirmPassword': createAdminRequest.confirmPassword,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> updateUser(UpdateUserRequest updateUserRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/update-user',
        data: {
          'originalEmail': updateUserRequest.originalEmail,
          'dniToBeFound': updateUserRequest.dniToBeFound,
          'username': updateUserRequest.username,
          'surname': updateUserRequest.surname,
          'email': updateUserRequest.email,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> deleteUser(DeleteUserRequest deleteUserRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/delete-user',
        data: {
          'email': deleteUserRequest.email,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> createNewPassword(CreateNewPasswordRequest createNewPasswordRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/create-new-password',
        data: {
          'userEmail': createNewPasswordRequest.userEmail,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> changePasswordWithPasswordAndEmail(ChangePasswordWithPasswordAndEmailRequest changePasswordWithPasswordAndEmailRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/change-password-with-password-and-email',
        data: {
          'userEmail': changePasswordWithPasswordAndEmailRequest.userEmail,
          'oldPassword': changePasswordWithPasswordAndEmailRequest.oldPassword,
          'newPassword': changePasswordWithPasswordAndEmailRequest.newPassword,
          'confirmNewPassword': changePasswordWithPasswordAndEmailRequest.confirmNewPassword,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }
    
    return data;
  }
}