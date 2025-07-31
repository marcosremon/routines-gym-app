import 'package:dio/dio.dart';
import 'package:routines_gym_app/configuration/constants/app_constants.dart';
import 'package:routines_gym_app/transversal/common/response_codes_json.dart';
import 'package:routines_gym_app/transversal/data_transfer_object_json/user/create/create_user/create_user_request_json.dart';
import 'package:routines_gym_app/transversal/data_transfer_object_json/user/create/create_user/create_user_response_json.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class UserDatasource {

  final Dio dio = Dio();

  Future<CreateUserResponseJson> createUser(CreateUserRequestJson createUserRequestJson) async {
    CreateUserResponseJson createUserResponseJson = CreateUserResponseJson();
    try 
    {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/create-user',
        data: {
          'dni': createUserRequestJson.dni,
          'username': createUserRequestJson.username,
          'email': createUserRequestJson.email,
          'password': createUserRequestJson.password,
          'confirmPassword': createUserRequestJson.confirmPassword,
        },
      );

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCode'] == ResponseCodesJson.ok) {
        createUserResponseJson.isSuccess = data['isSuccess'];
        createUserResponseJson.message = data['message'];
        createUserResponseJson.userDTO = data['userDTO'];
      } else {
        createUserResponseJson.isSuccess = false;
        createUserResponseJson.message = 'Error: ${response.statusMessage}';
      }      
    }
    catch (ex) 
    {
      createUserResponseJson.isSuccess = false;
      createUserResponseJson.message = 'unexpected error on UserDatasource -> createUser: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return createUserResponseJson;
  }

}