import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response.dart';

class GetAllUserFriendsResponse extends BaseResponse {
  List<UserDTO>? friends;

  GetAllUserFriendsResponse({
    bool success = false, 
    String message = '',
    this.friends,
  }) : super(isSuccess: success, message: message);
}
