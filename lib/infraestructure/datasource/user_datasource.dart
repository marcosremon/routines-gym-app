import 'package:dio/dio.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/change_password_with_password_and_email/change_password_with_password_and_email_reqeust.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/change_password_with_password_and_email/change_password_with_password_and_email_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_admin/create_admin_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_admin/create_admin_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_google_user/create_google_user_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_google_user/create_google_user_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_new_password/create_new_password_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_new_password/create_new_password_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_user/create_user_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_user/create_user_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/delete_user/delete_user_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/delete_user/delete_user_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/get/get_user_by_email/get_user_by_email_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/get/get_user_by_email/get_user_by_email_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/get/get_users/get_users_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/update_user/update_user_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/update_user/update_user_response.dart';
import 'package:routines_gym_app/configuration/constants/app_constants.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class UserDatasource {

  final Dio dio = Dio();

  Future<GetUsersResponse> getUsers() async 
  {
    GetUsersResponse getUsersResponse = GetUsersResponse();
    try 
    {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/get-users',
      );

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCodeJson'] == 200) {
        getUsersResponse.isSuccess = data['isSuccess'];
        getUsersResponse.message = data['message'];
        getUsersResponse.usersDTO = data['usersDTO'];
      } else {
        getUsersResponse.isSuccess = false;
        getUsersResponse.message = 'Error: ${response.statusMessage}';
      }      
    }
    catch (ex) 
    {
      getUsersResponse.isSuccess = false;
      getUsersResponse.message = 'unexpected error on UserDatasource -> getUsers: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return getUsersResponse;
  }

  Future<GetUserByEmailResponse> getUserByEmail(GetUserByEmailRequest getUserByEmailRequest) async 
  {
    GetUserByEmailResponse getUserByEmailResponse = GetUserByEmailResponse();
    try 
    {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/get-user-by-email',
        data: {
          'email': getUserByEmailRequest.email,
        },
      );

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCodeJson'] == 200) {
         getUserByEmailResponse.isSuccess = data['isSuccess'];
         getUserByEmailResponse.message = data['message'];
         getUserByEmailResponse.userDTO = data['userDTO'];
         getUserByEmailResponse.routinesCount = data['routinesCount'];
         getUserByEmailResponse.friendsCount = data['friendsCount'];
      } else {
         getUserByEmailResponse.isSuccess = false;
         getUserByEmailResponse.message = 'Error: ${response.statusMessage}';
      }      
    }
    catch (ex) 
    {
       getUserByEmailResponse.isSuccess = false;
       getUserByEmailResponse.message = 'unexpected error on UserDatasource -> getUserByEmail: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return  getUserByEmailResponse;
  }

  Future<CreateUserResponse> createUser(CreateUserRequest createUserRequest) async 
  {
    CreateUserResponse createUserResponse = CreateUserResponse();
    try 
    {
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

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCodeJson'] == 200) {        
        createUserResponse.isSuccess = data['isSuccess'];
        createUserResponse.message = data['message'];
        createUserResponse.userDTO = UserDTO.fromJson(data['userDTO']);
      } else {
        createUserResponse.isSuccess = false;
        createUserResponse.message = 'Error: ${response.statusMessage}';
      }      
    }
    catch (ex) {
      createUserResponse.isSuccess = false;
      createUserResponse.message = 'unexpected error on UserDatasource -> createUser: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return createUserResponse;
  }

  Future<CreateGoogleUserResponse> createGoolgeUser(CreateGoogleUserRequest createGoogleUserRequest) async 
  {
    CreateGoogleUserResponse createGoogleUserResponse = CreateGoogleUserResponse();
    try 
    {
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

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCodeJson'] == 200) {
         createGoogleUserResponse.isSuccess = data['isSuccess'];
         createGoogleUserResponse.message = data['message'];
         createGoogleUserResponse.userDTO = data['userDTO'];
      } else {
         createGoogleUserResponse.isSuccess = false;
         createGoogleUserResponse.message = 'Error: ${response.statusMessage}';
      }      
    }
    catch (ex) 
    {
       createGoogleUserResponse.isSuccess = false;
       createGoogleUserResponse.message = 'unexpected error on UserDatasource -> createGoogleUser: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return  createGoogleUserResponse;
  }

  Future<CreateAdminResponse> createAdmin(CreateAdminRequest createAdminRequest) async 
  {
    CreateAdminResponse createAdminResponse = CreateAdminResponse();
    try 
    {
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

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCodeJson'] == 200) {
         createAdminResponse.isSuccess = data['isSuccess'];
         createAdminResponse.message = data['message'];
      } else {
         createAdminResponse.isSuccess = false;
         createAdminResponse.message = 'Error: ${response.statusMessage}';
      }      
    }
    catch (ex) 
    {
       createAdminResponse.isSuccess = false;
       createAdminResponse.message = 'unexpected error on UserDatasource -> createAdmin: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return  createAdminResponse;
  }

  Future<UpdateUserResponse> updateUser(UpdateUserRequest updateUserRequest) async 
  {
    UpdateUserResponse updateUserResponse = UpdateUserResponse();
    try 
    {
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

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCodeJson'] == 200) {
         updateUserResponse.isSuccess = data['isSuccess'];
         updateUserResponse.message = data['message'];
         updateUserResponse.userDTO = data['userDTO'];
      } else {
         updateUserResponse.isSuccess = false;
         updateUserResponse.message = 'Error: ${response.statusMessage}';
      }      
    }
    catch (ex) 
    {
       updateUserResponse.isSuccess = false;
       updateUserResponse.message = 'unexpected error on UserDatasource -> updateUser: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return  updateUserResponse;
  }

  Future<DeleteUserResponse> deleteUser(DeleteUserRequest deleteUserRequest) async 
  {
    DeleteUserResponse deleteUserResponse = DeleteUserResponse();
    try 
    {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/delete-user',
        data: {
          'email': deleteUserRequest.email,
        },
      );

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCodeJson'] == 200) {
         deleteUserResponse.isSuccess = data['isSuccess'];
         deleteUserResponse.message = data['message'];
         deleteUserResponse.userId = data['userId'];
      } else {
         deleteUserResponse.isSuccess = false;
         deleteUserResponse.message = 'Error: ${response.statusMessage}';
      }      
    }
    catch (ex) 
    {
       deleteUserResponse.isSuccess = false;
       deleteUserResponse.message = 'unexpected error on UserDatasource -> deleteUser: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return  deleteUserResponse;
  }

  Future<CreateNewPasswordResponse> createNewPassword(CreateNewPasswordRequest createNewPasswordRequest) async 
  {
    CreateNewPasswordResponse createNewPasswordResponse = CreateNewPasswordResponse();
    try 
    {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/create-new-password',
        data: {
          'userEmail': createNewPasswordRequest.userEmail,
        },
      );

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCodeJson'] == 200) {
         createNewPasswordResponse.isSuccess = data['isSuccess'];
         createNewPasswordResponse.message = data['message'];
         createNewPasswordResponse.userId = data['userId'];
      } else {
         createNewPasswordResponse.isSuccess = false;
         createNewPasswordResponse.message = 'Error: ${response.statusMessage}';
      }      
    }
    catch (ex) 
    {
       createNewPasswordResponse.isSuccess = false;
       createNewPasswordResponse.message = 'unexpected error on UserDatasource -> createNewPassword: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return  createNewPasswordResponse;
  }

  Future<ChangePasswordWithPasswordAndEmailResponse> changePasswordWithPasswordAndEmail(ChangePasswordWithPasswordAndEmailRequest changePasswordWithPasswordAndEmailRequest) async 
  {
    ChangePasswordWithPasswordAndEmailResponse changePasswordWithPasswordAndEmailResponse = ChangePasswordWithPasswordAndEmailResponse();
    try 
    {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/change-password-with-password-and-email',
        data: {
          'userEmail': changePasswordWithPasswordAndEmailRequest.userEmail,
          'oldPassword': changePasswordWithPasswordAndEmailRequest.oldPassword,
          'newPassword': changePasswordWithPasswordAndEmailRequest.newPassword,
          'confirmNewPassword': changePasswordWithPasswordAndEmailRequest.confirmNewPassword,
        },
      );

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCodeJson'] == 200) {
         changePasswordWithPasswordAndEmailResponse.isSuccess = data['isSuccess'];
         changePasswordWithPasswordAndEmailResponse.message = data['message'];
         changePasswordWithPasswordAndEmailResponse.userId = data['userId'];
      } else {
         changePasswordWithPasswordAndEmailResponse.isSuccess = false;
         changePasswordWithPasswordAndEmailResponse.message = 'Error: ${response.statusMessage}';
      }      
    }
    catch (ex) 
    {
       changePasswordWithPasswordAndEmailResponse.isSuccess = false;
       changePasswordWithPasswordAndEmailResponse.message = 'unexpected error on UserDatasource -> changePasswordWithPasswordAndEmail: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return  changePasswordWithPasswordAndEmailResponse;
  }
}