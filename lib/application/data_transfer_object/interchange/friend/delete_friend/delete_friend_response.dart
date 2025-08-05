// ignore_for_file: strict_top_level_inference

import 'package:routines_gym_app/transversal/common/base_response.dart';

class DeleteFriendResponse extends BaseResponse {
  DeleteFriendResponse({
    success,
    message,
  }) : super(isSuccess: success);

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
