import 'package:flutter/foundation.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_new_password/create_new_password_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_new_password/create_new_password_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_user/create_user_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_user/create_user_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/get/get_user_profile_detials/get_user_profile_details_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/get/get_user_profile_detials/get_user_profile_details_response.dart';
import 'package:routines_gym_app/infraestructure/repository/user_repository.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  
  final UserRepository userRepository = UserRepository();

  Future<CreateUserResponse> createUser(CreateUserRequest createUserRequest) async {
    return await userRepository.createUser(createUserRequest);
  }

  Future<void> createNewPassword(CreateNewPasswordRequest createNewPasswordRequest) async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CreateNewPasswordRequest createNewPasswordRequest = CreateNewPasswordRequest(
        userEmail: prefs.getString("userEmail") ?? ""
      );

      CreateNewPasswordResponse createNewPasswordResponse = await userRepository.createNewPassword(createNewPasswordRequest);
      ToastMessage.showToast(createNewPasswordResponse.message!);
  }

  Future<GetUserProfileDetilesResponse> getUserProfileDetails(GetUserProfileDetilesRequest getUserProfileDetilesRequest) async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getUserProfileDetilesRequest.userEmail ??= prefs.getString("userEmail");
    
    return await userRepository.getUserProfileDetails(getUserProfileDetilesRequest);
  }  
}