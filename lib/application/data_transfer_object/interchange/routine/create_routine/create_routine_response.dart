// ignore_for_file: strict_top_level_inference

import 'package:routines_gym_app/transversal/common/base_response.dart';

class CreateRoutineResponse extends BaseResponse {

  CreateRoutineResponse({
    success,
    message,
  }) : super(isSuccess: success);

  factory CreateRoutineResponse.fromJson(Map<String, dynamic> json) {
    return CreateRoutineResponse(
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