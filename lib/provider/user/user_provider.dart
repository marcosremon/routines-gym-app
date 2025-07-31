import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_user/create_user_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_user/create_user_response.dart';
import 'package:routines_gym_app/infraestructure/repository/user_repository.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class UserProvider extends ChangeNotifier {
  
  final UserRepository userRepository = UserRepository();

  Future<CreateUserResponse> createUser(CreateUserRequest createUserRequest) async {
    CreateUserResponse createUserResponse = CreateUserResponse();
    try
    {
      createUserResponse = await userRepository.createUser(createUserRequest);
    }
    catch (ex) 
    {
      createUserResponse.isSuccess = false;
      createUserResponse.message = 'unexpected error on UserProvider -> createUser: ${ex.toString()}';
      ToastMessage.showToast('unexpected error');
    }

    return createUserResponse;
  }
}