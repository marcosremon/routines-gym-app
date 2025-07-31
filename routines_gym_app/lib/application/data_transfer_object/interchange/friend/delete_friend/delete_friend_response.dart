import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class DeleteFriendResponse extends BaseResponseJson {
  DeleteFriendResponse({
    required bool success,
    required String message,
  }) : super(isSuccess: success, message: message);

  factory DeleteFriendResponse.fromJson(Map<String, dynamic> json) {
    return DeleteFriendResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}
