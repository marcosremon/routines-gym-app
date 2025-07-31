import 'package:routines_gym_app/application/data_transfer_object/entities/exercise_dto.dart';
import 'package:routines_gym_app/transversal/common/base_response_json.dart';
import 'package:routines_gym_app/transversal/common/response_codes_json.dart';

class GetExercisesByDayAndRoutineIdResponseJson extends BaseResponseJson {
  List<ExerciseDTO> exercises;
  Map<int, List<String>> pastProgress;

  GetExercisesByDayAndRoutineIdResponseJson({
    this.exercises = const [],
    this.pastProgress = const {},
    super.responseCodeJson,
    super.isSuccess,
    super.message,
  });

  factory GetExercisesByDayAndRoutineIdResponseJson.fromJson(Map<String, dynamic> json) {
    return GetExercisesByDayAndRoutineIdResponseJson(
      exercises: (json['exercises'] as List<dynamic>?)
              ?.map((e) => ExerciseDTO.fromJson(e))
              .toList() ??
          [],
      pastProgress: (json['pastProgress'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(
              int.parse(key),
              (value as List<dynamic>).map((e) => e.toString()).toList(),
            ),
          ) ??
          {},
      responseCodeJson: json['responseCodeJson'] != null
          ? ResponseCodesJson.fromValue(json['responseCodeJson'])
          : null,
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'exercises': exercises.map((e) => e.toJson()).toList(),
        'pastProgress': pastProgress.map(
          (key, value) => MapEntry(key.toString(), value),
        ),
        'responseCodeJson': responseCodeJson?.value,
        'isSuccess': isSuccess,
        'message': message,
      };
}