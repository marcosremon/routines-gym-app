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
    this.dayExercisesDescription = '',
    List<ExerciseDTO>? exercises,
  }) : exercises = exercises ?? [];

  Map<String, dynamic> toJson() {
    return {
      'DayName': dayName.index + 1, 
      'RoutineId': routineId,
      'DayExercisesDescription': dayExercisesDescription,
      'Exercises': exercises.map((e) => e.toJson()).toList(),
    };
  }

  factory SplitDayDTO.fromJson(Map<String, dynamic> json) {
    return SplitDayDTO(
      dayName: WeekDay.values[(json['DayName'] ?? 1) - 1],
      routineId: json['RoutineId'] ?? 0,
      dayExercisesDescription: json['DayExercisesDescription'] ?? '',
      exercises: (json['Exercises'] as List<dynamic>?)
              ?.map((e) => ExerciseDTO.fromJson(e))
              .toList() ??
          [],
    );
  }
}
