import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class AddNewUserFriendResponseJson extends BaseResponseJson {
  int friendId;

  AddNewUserFriendResponseJson({
    required bool success,
    required String message,
    required this.friendId,
  }) : super(isSuccess: success, message: message);

  factory AddNewUserFriendResponseJson.fromJson(Map<String, dynamic> json) {
    return AddNewUserFriendResponseJson(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      friendId: json['friendId'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['friendId'] = friendId;
    return data;
  }
}
