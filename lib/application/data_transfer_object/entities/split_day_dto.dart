import 'package:routines_gym_app/application/data_transfer_object/entities/exercise_dto.dart';
import 'package:routines_gym_app/domain/model/enums/week_day.dart';

class SplitDayDTO {
  WeekDay dayName;
  int routineId;
  String dayExercisesDescription;
  List<ExerciseDTO> exercises;

  SplitDayDTO({
    required this.dayName,
    required this.routineId,
    required this.dayExercisesDescription,
    required this.exercises,
  });

  factory SplitDayDTO.fromJson(Map<String, dynamic> json) {
    return SplitDayDTO(
      dayName: WeekDay.values.firstWhere(
        (e) => e.name.toLowerCase() == (json['dayName'] ?? '').toLowerCase(),
        orElse: () => WeekDay.monday,
      ),
      routineId: json['routineId'] ?? 0,
      dayExercisesDescription: json['dayExercisesDescription'] ?? '',
      exercises: (json['exercises'] as List<dynamic>? ?? [])
          .map((e) => ExerciseDTO.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayName': dayName.name,
      'routineId': routineId,
      'dayExercisesDescription': dayExercisesDescription,
      'exercises': exercises.map((e) => e.toJson()).toList(),
    };
  }
}