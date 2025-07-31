import 'package:routines_gym_app/transversal/common/base_response.dart';

class GetRoutineStatsResponse extends BaseResponse {
  int routinesCount;
  int exercisesCount;
  int splitsCount;

  GetRoutineStatsResponse({
    required bool success,
    required String message,
    required this.routinesCount,
    required this.exercisesCount,
    required this.splitsCount,
  }) : super(isSuccess: success, message: message);

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
