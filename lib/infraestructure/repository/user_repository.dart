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
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class UserRepository {
  final UserDatasource userDatasource = UserDatasource();

  Future<GetUsersResponse> getUsers() async {
    GetUsersResponse getUsersResponse = GetUsersResponse();
    try {
      GetUsersResponse getUsersResponseJson = await userDatasource.getUsers();
      getUsersResponse.isSuccess = getUsersResponseJson.isSuccess;
      getUsersResponse.message = getUsersResponseJson.message;
      getUsersResponse.usersDTO = getUsersResponseJson.usersDTO;
      getUsersResponse.responseCode = ResponseCodes.fromValue(getUsersResponseJson.responseCode?.value ?? 0);
    } catch (ex) {
      getUsersResponse.isSuccess = false;
      getUsersResponse.message = 'Unexpected error on UserRepository -> getUsers: ${ex.toString()}';
      ToastMessage.showToast("Unexpected error");
    }

    return getUsersResponse;
  }

  Future<GetUserByEmailResponse> getUsersByEmail(GetUserByEmailRequest getUserByEmailRequest) async {
    GetUserByEmailResponse getUserByEmailResponse = GetUserByEmailResponse();
    try {
      GetUserByEmailResponse getUserByEmailResponseJson = await userDatasource.getUserByEmail(getUserByEmailRequest);
      getUserByEmailResponse.isSuccess = getUserByEmailResponseJson.isSuccess;
      getUserByEmailResponse.message = getUserByEmailResponseJson.message;
      getUserByEmailResponse.userDTO = getUserByEmailResponseJson.userDTO;
      getUserByEmailResponse.routinesCount = getUserByEmailResponseJson.routinesCount;
      getUserByEmailResponse.friendsCount = getUserByEmailResponseJson.friendsCount;
      getUserByEmailResponse.responseCode = ResponseCodes.fromValue(getUserByEmailResponseJson.responseCode?.value ?? 0);
    } catch (ex) {
      getUserByEmailResponse.isSuccess = false;
      getUserByEmailResponse.message = 'Unexpected error on UserRepository -> getUsersByEmail: ${ex.toString()}';
      ToastMessage.showToast("Unexpected error");
    }
    return getUserByEmailResponse;
  }

  Future<CreateUserResponse> createUser(CreateUserRequest createUserRequest) async {
    CreateUserResponse createUserResponse = CreateUserResponse();
    try {
      CreateUserResponse createUserResponseJson = await userDatasource.createUser(createUserRequest);
      createUserResponse.isSuccess = createUserResponseJson.isSuccess;
      createUserResponse.message = createUserResponseJson.message;  
      createUserResponse.userDTO = createUserResponseJson.userDTO;
      createUserResponse.responseCode = ResponseCodes.fromValue(createUserResponseJson.responseCode?.value ?? 0);
    } catch (ex) {
      createUserResponse.isSuccess = false;
      createUserResponse.message = 'Unexpected error on UserRepository -> createUser: ${ex.toString()}';
      ToastMessage.showToast("Unexpected error");
    }

    return createUserResponse;
  }

  Future<CreateGoogleUserResponse> createGoogleUser(CreateGoogleUserRequest createGoogleUserRequest) async {
    CreateGoogleUserResponse createGoogleUserResponse = CreateGoogleUserResponse();
    try {
      CreateGoogleUserResponse createGoogleUserResponseJson = await userDatasource.createGoolgeUser(createGoogleUserRequest);
      createGoogleUserResponse.isSuccess = createGoogleUserResponseJson.isSuccess;
      createGoogleUserResponse.message = createGoogleUserResponseJson.message;
      createGoogleUserResponse.userDTO = createGoogleUserResponseJson.userDTO;
      createGoogleUserResponse.responseCode = ResponseCodes.fromValue(createGoogleUserResponseJson.responseCode?.value ?? 0);
    } catch (ex) {
      createGoogleUserResponse.isSuccess = false;
      createGoogleUserResponse.message = 'Unexpected error on UserRepository -> createGoogleUser: ${ex.toString()}';
      ToastMessage.showToast("Unexpected error");
    }

    return createGoogleUserResponse;
  }

  Future<CreateAdminResponse> createAdmin(CreateAdminRequest createAdminRequest) async {
    CreateAdminResponse createAdminResponse = CreateAdminResponse();
    try {
      CreateAdminResponse createAdminResponseJson = await userDatasource.createAdmin(createAdminRequest);
      createAdminResponse.isSuccess = createAdminResponseJson.isSuccess;
      createAdminResponse.message = createAdminResponseJson.message;
      createAdminResponse.responseCode = ResponseCodes.fromValue(createAdminResponseJson.responseCode?.value ?? 0);
    } catch (ex) {
      createAdminResponse.isSuccess = false;
      createAdminResponse.message = 'Unexpected error on UserRepository -> createAdmin: ${ex.toString()}';
      ToastMessage.showToast("Unexpected error");
    }

    return createAdminResponse;
  }

  Future<UpdateUserResponse> updateUser(UpdateUserRequest updateUserRequest) async {
    UpdateUserResponse updateUserResponse = UpdateUserResponse();
    try {
      UpdateUserResponse updateUserResponseJson = await userDatasource.updateUser(updateUserRequest);
      updateUserResponse.isSuccess = updateUserResponseJson.isSuccess;
      updateUserResponse.message = updateUserResponseJson.message;
      updateUserResponse.userDTO = updateUserResponseJson.userDTO;
      updateUserResponse.responseCode = ResponseCodes.fromValue(updateUserResponseJson.responseCode?.value ?? 0);
    } catch (ex) {
      updateUserResponse.isSuccess = false;
      updateUserResponse.message = 'Unexpected error on UserRepository -> updateUser: ${ex.toString()}';
      ToastMessage.showToast("Unexpected error");
    }

    return updateUserResponse;
  }

  Future<DeleteUserResponse> deleteUser(DeleteUserRequest deleteUserRequest) async {
    DeleteUserResponse deleteUserResponse = DeleteUserResponse();
    try {
      DeleteUserResponse deleteUserResponseJson = await userDatasource.deleteUser(deleteUserRequest);
      deleteUserResponse.isSuccess = deleteUserResponseJson.isSuccess;
      deleteUserResponse.message = deleteUserResponseJson.message;
      deleteUserResponse.userId = deleteUserResponseJson.userId;
      deleteUserResponse.responseCode = ResponseCodes.fromValue(deleteUserResponseJson.responseCode?.value ?? 0);
    } catch (ex) {
      deleteUserResponse.isSuccess = false;
      deleteUserResponse.message = 'Unexpected error on UserRepository -> deleteUser: ${ex.toString()}';
      ToastMessage.showToast("Unexpected error");
    }

    return deleteUserResponse;
  }

  Future<CreateNewPasswordResponse> createNewPassword(CreateNewPasswordRequest createNewPasswordRequest) async {
    CreateNewPasswordResponse createNewPasswordResponse = CreateNewPasswordResponse();
    try {
      CreateNewPasswordResponse createNewPasswordResponseJson = await userDatasource.createNewPassword(createNewPasswordRequest);
      createNewPasswordResponse.isSuccess = createNewPasswordResponseJson.isSuccess;
      createNewPasswordResponse.message = createNewPasswordResponseJson.message;
      createNewPasswordResponse.userId = createNewPasswordResponseJson.userId;
      createNewPasswordResponse.responseCode = ResponseCodes.fromValue(createNewPasswordResponseJson.responseCode?.value ?? 0);
    } catch (ex) {
      createNewPasswordResponse.isSuccess = false;
      createNewPasswordResponse.message = 'Unexpected error on UserRepository -> createNewPassword: ${ex.toString()}';
      ToastMessage.showToast("Unexpected error");
    }

    return createNewPasswordResponse;
  }

  Future<ChangePasswordWithPasswordAndEmailResponse> changePasswordWithPasswordAndEmail(ChangePasswordWithPasswordAndEmailRequest changePasswordWithPasswordAndEmailRequest) async {
    ChangePasswordWithPasswordAndEmailResponse changePasswordWithPasswordAndEmailResponse = ChangePasswordWithPasswordAndEmailResponse();
    try {
      ChangePasswordWithPasswordAndEmailResponse changePasswordWithPasswordAndEmailResponseJson = await userDatasource.changePasswordWithPasswordAndEmail(changePasswordWithPasswordAndEmailRequest);
      changePasswordWithPasswordAndEmailResponse.isSuccess = changePasswordWithPasswordAndEmailResponseJson.isSuccess;
      changePasswordWithPasswordAndEmailResponse.message = changePasswordWithPasswordAndEmailResponseJson.message;
      changePasswordWithPasswordAndEmailResponse.userId = changePasswordWithPasswordAndEmailResponseJson.userId;
      changePasswordWithPasswordAndEmailResponse.responseCode = ResponseCodes.fromValue(changePasswordWithPasswordAndEmailResponseJson.responseCode?.value ?? 0);
    } catch (ex) {
      changePasswordWithPasswordAndEmailResponse.isSuccess = false;
      changePasswordWithPasswordAndEmailResponse.message = 'Unexpected error on UserRepository -> changePasswordWithPasswordAndEmail: ${ex.toString()}';
      ToastMessage.showToast("Unexpected error");
    }

    return changePasswordWithPasswordAndEmailResponse;
  }
}