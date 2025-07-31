import 'package:routines_gym_app/transversal/common/base_response_json.dart';

class DeleteFriendResponseJson extends BaseResponseJson {
  DeleteFriendResponseJson({
    required bool success,
    required String message,
  }) : super(isSuccess: success, message: message);

  factory DeleteFriendResponseJson.fromJson(Map<String, dynamic> json) {
    return DeleteFriendResponseJson(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}
