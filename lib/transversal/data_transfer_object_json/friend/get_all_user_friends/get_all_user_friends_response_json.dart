import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class GetAllUserFriendsResponseJson extends BaseResponseJson {
  List<UserDTO> friends;

  GetAllUserFriendsResponseJson({
    required bool success,
    required String message,
    required this.friends,
  }) : super(isSuccess: success, message: message);

  factory GetAllUserFriendsResponseJson.fromJson(Map<String, dynamic> json) {
    return GetAllUserFriendsResponseJson(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      friends: (json['friends'] as List<dynamic>? ?? [])
          .map((e) => UserDTO.fromJson(e))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['friends'] = friends.map((e) => e.toJson()).toList();
    return data;
  }
}
