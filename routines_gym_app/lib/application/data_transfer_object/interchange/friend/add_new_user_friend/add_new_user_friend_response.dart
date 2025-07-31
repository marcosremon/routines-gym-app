import 'package:routines_gym_app/transversal/common/base_response.dart';

class AddNewUserFriendResponse extends BaseResponse {
  int friendId;

  AddNewUserFriendResponse({
    required bool success,
    required String message,
    required this.friendId,
  }) : super(isSuccess: success, message: message);

  factory AddNewUserFriendResponse.fromJson(Map<String, dynamic> json) {
    return AddNewUserFriendResponse(
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
