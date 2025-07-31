import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_user/create_user_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_user/create_user_response.dart';
import 'package:routines_gym_app/infraestructure/datasource/user_datasource.dart';
import 'package:routines_gym_app/transversal/common/response_codes.dart';
import 'package:routines_gym_app/transversal/data_transfer_object_json/user/create/create_user/create_user_request_json.dart';
import 'package:routines_gym_app/transversal/data_transfer_object_json/user/create/create_user/create_user_response_json.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class UserRepository {

  final UserDatasource userDatasource = UserDatasource();

  Future<CreateUserResponse> createUser(CreateUserRequest createUserRequest) async {
    CreateUserResponse createUserResponse = CreateUserResponse();
    try 
    {
      CreateUserRequestJson createUserRequestJson = CreateUserRequestJson(
        dni: createUserRequest.dni,
        username: createUserRequest.username,
        surname: createUserRequest.surname,
        email: createUserRequest.email,
        password: createUserRequest.password,
        confirmPassword: createUserRequest.confirmPassword,
      );

      CreateUserResponseJson createUserResponseJson = await userDatasource.createUser(createUserRequestJson);
      createUserResponse.isSuccess = createUserResponseJson.isSuccess;
      createUserResponse.message = createUserResponseJson.message;  
      createUserResponse.userDTO = createUserResponseJson.userDTO;
      createUserResponse.responseCode = ResponseCodes.fromValue(createUserResponseJson.responseCodeJson!.value);
    }
    catch (ex) 
    {
      createUserResponse.isSuccess = false;
      createUserResponse.message = 'unexpected error on UserRepository -> createUser: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return createUserResponse;
  }

}