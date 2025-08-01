import 'package:routines_gym_app/transversal/common/base_response.dart';

class AddNewUserFriendResponse extends BaseResponse {
  int? friendId;

  AddNewUserFriendResponse({
    success,
    message,
    this.friendId,
  }) : super(isSuccess: success);

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
