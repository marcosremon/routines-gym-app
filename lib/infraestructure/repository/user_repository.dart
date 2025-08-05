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
import 'package:routines_gym_app/infraestructure/datasource/user_datasource.dart';
import 'package:routines_gym_app/transversal/common/response_codes.dart';

class UserRepository {
  final UserDatasource userDatasource = UserDatasource();

  Future<GetUsersResponse> getUsers() async {
    GetUsersResponse getUsersResponse = GetUsersResponse();
    try {
      Map<String, dynamic> data = await userDatasource.getUsers();
      if (data['responseCodeJson'] == 200) {
        getUsersResponse.isSuccess = data['isSuccess'];
        getUsersResponse.message = data['message'];
        getUsersResponse.usersDTO = data['usersDTO'];
      } else {
        getUsersResponse.isSuccess = false;
        getUsersResponse.message = 'Error: ${data['message']}';
      }
      getUsersResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } catch (ex) {
      getUsersResponse.isSuccess = false;
      getUsersResponse.message = 'Unexpected error on UserRepository -> getUsers';
    }
    return getUsersResponse;
  }

  Future<GetUserByEmailResponse> getUsersByEmail(GetUserByEmailRequest getUserByEmailRequest) async {
    GetUserByEmailResponse getUserByEmailResponse = GetUserByEmailResponse();
    try {
      Map<String, dynamic> data = await userDatasource.getUserByEmail(getUserByEmailRequest);
      if (data['responseCodeJson'] == 200) {
        getUserByEmailResponse.isSuccess = data['isSuccess'];
        getUserByEmailResponse.message = data['message'];
        getUserByEmailResponse.userDTO = UserDTO.fromJson(data['userDTO']);
        getUserByEmailResponse.routinesCount = data['routinesCount'];
        getUserByEmailResponse.friendsCount = data['friendsCount'];
      } else {
        getUserByEmailResponse.isSuccess = false;
        getUserByEmailResponse.message = 'Error: ${data['message']}';
      }
      getUserByEmailResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } catch (ex) {
      getUserByEmailResponse.isSuccess = false;
      getUserByEmailResponse.message = 'Unexpected error on UserRepository -> createUser';
    }
    
    return getUserByEmailResponse;
  }

  Future<CreateUserResponse> createUser(CreateUserRequest createUserRequest) async {
    CreateUserResponse createUserResponse = CreateUserResponse();
    try {
      Map<String, dynamic> data = await userDatasource.createUser(createUserRequest);
      if (data['responseCodeJson'] == 200) {
        createUserResponse.isSuccess = data['isSuccess'];
        createUserResponse.message = data['message'];
      } else {
        createUserResponse.isSuccess = false;
        createUserResponse.message = 'Error: ${data['message']}';
      }
      createUserResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } catch (ex) {
      createUserResponse.isSuccess = false;
      createUserResponse.message = 'Unexpected error on UserRepository -> createUser';
    }
    return createUserResponse;
  }

  Future<CreateGoogleUserResponse> createGoogleUser(CreateGoogleUserRequest createGoogleUserRequest) async {
    CreateGoogleUserResponse createGoogleUserResponse = CreateGoogleUserResponse();
    try {
      Map<String, dynamic> data = await userDatasource.createGoolgeUser(createGoogleUserRequest);
      if (data['responseCodeJson'] == 200) {
        createGoogleUserResponse.isSuccess = data['isSuccess'];
        createGoogleUserResponse.message = data['message'];
      } else {
        createGoogleUserResponse.isSuccess = false;
        createGoogleUserResponse.message = 'Error: ${data['message']}';
      }
      createGoogleUserResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } catch (ex) {
      createGoogleUserResponse.isSuccess = false;
      createGoogleUserResponse.message = 'Unexpected error on UserRepository -> createGoogleUser';
    }
    return createGoogleUserResponse;
  }

  Future<CreateAdminResponse> createAdmin(CreateAdminRequest createAdminRequest) async {
    CreateAdminResponse createAdminResponse = CreateAdminResponse();
    try {
      Map<String, dynamic> data = await userDatasource.createAdmin(createAdminRequest);
      if (data['responseCodeJson'] == 200) {
        createAdminResponse.isSuccess = data['isSuccess'];
        createAdminResponse.message = data['message'];
      } else {
        createAdminResponse.isSuccess = false;
        createAdminResponse.message = 'Error: ${data['message']}';
      }
      createAdminResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } catch (ex) {
      createAdminResponse.isSuccess = false;
      createAdminResponse.message = 'Unexpected error on UserRepository -> createAdmin';
    }
    return createAdminResponse;
  }

  Future<UpdateUserResponse> updateUser(UpdateUserRequest updateUserRequest) async {
    UpdateUserResponse updateUserResponse = UpdateUserResponse();
    try {
      Map<String, dynamic> data = await userDatasource.updateUser(updateUserRequest);
      if (data['responseCodeJson'] == 200) {
        updateUserResponse.isSuccess = data['isSuccess'];
        updateUserResponse.message = data['message'];
        updateUserResponse.userDTO = data['userDTO'];
      } else {
        updateUserResponse.isSuccess = false;
        updateUserResponse.message = 'Error: ${data['message']}';
      }
      updateUserResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } catch (ex) {
      updateUserResponse.isSuccess = false;
      updateUserResponse.message = 'Unexpected error on UserRepository -> updateUser';
    }
    return updateUserResponse;
  }

  Future<DeleteUserResponse> deleteUser(DeleteUserRequest deleteUserRequest) async {
    DeleteUserResponse deleteUserResponse = DeleteUserResponse();
    try {
      Map<String, dynamic> data = await userDatasource.deleteUser(deleteUserRequest);
      if (data['responseCodeJson'] == 200) {
        deleteUserResponse.isSuccess = data['isSuccess'];
        deleteUserResponse.message = data['message'];
      } else {
        deleteUserResponse.isSuccess = false;
        deleteUserResponse.message = 'Error: ${data['message']}';
      }
      deleteUserResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } catch (ex) {
      deleteUserResponse.isSuccess = false;
      deleteUserResponse.message = 'Unexpected error on UserRepository -> deleteUser';
    }
    return deleteUserResponse;
  }

  Future<CreateNewPasswordResponse> createNewPassword(CreateNewPasswordRequest createNewPasswordRequest) async {
    CreateNewPasswordResponse createNewPasswordResponse = CreateNewPasswordResponse();
    try {
      Map<String, dynamic> data = await userDatasource.createNewPassword(createNewPasswordRequest);
      if (data['responseCodeJson'] == 200) {
        createNewPasswordResponse.isSuccess = data['isSuccess'];
        createNewPasswordResponse.message = data['message'];
      } else {
        createNewPasswordResponse.isSuccess = false;
        createNewPasswordResponse.message = 'Error: ${data['message']}';
      }
      createNewPasswordResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } catch (ex) {
      createNewPasswordResponse.isSuccess = false;
      createNewPasswordResponse.message = 'Unexpected error on UserRepository -> createNewPassword';
    }
    return createNewPasswordResponse;
  }

  Future<ChangePasswordWithPasswordAndEmailResponse> changePasswordWithPasswordAndEmail(ChangePasswordWithPasswordAndEmailRequest changePasswordWithPasswordAndEmailRequest) async {
    ChangePasswordWithPasswordAndEmailResponse changePasswordWithPasswordAndEmailResponse = ChangePasswordWithPasswordAndEmailResponse();
    try {
      Map<String, dynamic> data = await userDatasource.changePasswordWithPasswordAndEmail(changePasswordWithPasswordAndEmailRequest);
      if (data['responseCodeJson'] == 200) {
        changePasswordWithPasswordAndEmailResponse.isSuccess = data['isSuccess'];
        changePasswordWithPasswordAndEmailResponse.message = data['message'];
      } else {
        changePasswordWithPasswordAndEmailResponse.isSuccess = false;
        changePasswordWithPasswordAndEmailResponse.message = 'Error: ${data['message']}';
      }
      changePasswordWithPasswordAndEmailResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } catch (ex) {
      changePasswordWithPasswordAndEmailResponse.isSuccess = false;
      changePasswordWithPasswordAndEmailResponse.message = 'Unexpected error on UserRepository -> changePasswordWithPasswordAndEmail';
    }
    return changePasswordWithPasswordAndEmailResponse;
  }
}