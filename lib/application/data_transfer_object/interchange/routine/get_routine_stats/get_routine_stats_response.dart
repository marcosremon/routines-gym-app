// ignore_for_file: strict_top_level_inference

import 'package:routines_gym_app/transversal/common/base_response.dart';

class GetRoutineStatsResponse extends BaseResponse {
  int? routinesCount;
  int? exercisesCount;
  int? splitsCount;

  GetRoutineStatsResponse({
    success,
    message,
    this.routinesCount,
    this.exercisesCount,
    this.splitsCount,
  }) : super(isSuccess: success);

  factory GetRoutineStatsResponse.fromJson(Map<String, dynamic> json) {
    return GetRoutineStatsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      routinesCount: json['routinesCount'] ?? 0,
      exercisesCount: json['exercisesCount'] ?? 0,
      splitsCount: json['splitsCount'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['routinesCount'] = routinesCount;
    data['exercisesCount'] = exercisesCount;
    data['splitsCount'] = splitsCount;
    return data;
  }
}
