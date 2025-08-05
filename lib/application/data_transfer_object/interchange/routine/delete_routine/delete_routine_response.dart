// ignore_for_file: strict_top_level_inference

import 'package:routines_gym_app/transversal/common/base_response.dart';

class DeleteRoutineResponse extends BaseResponse {

  DeleteRoutineResponse({
    success,
    message,
  }) : super(isSuccess: success);

  factory DeleteRoutineResponse.fromJson(Map<String, dynamic> json) {
    return DeleteRoutineResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    return data;
  }
}
