import 'package:routines_gym_app/application/data_transfer_object/entities/exercise_dto.dart';
import 'package:routines_gym_app/domain/model/enums/week_day.dart';

class SplitDayDTO {
  WeekDay dayName;
  String name; 
  int routineId;
  String dayExercisesDescription;
  List<ExerciseDTO> exercises;

  SplitDayDTO({
    required this.dayName,
    required this.name,
    required this.routineId,
    this.dayExercisesDescription = '',
    List<ExerciseDTO>? exercises,
  }) : exercises = exercises ?? [];

  factory SplitDayDTO.fromJson(Map<String, dynamic> json) {
    // Los campos vienen en camelCase, no PascalCase
    final dayIndex = ((json['dayName'] ?? 1) - 1).clamp(0, 6);
    final dayEnum = WeekDay.values[dayIndex];

    // Nombres de los días en inglés
    const weekDayNames = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];

    return SplitDayDTO(
      dayName: dayEnum,
      name: weekDayNames[dayIndex],
      routineId: json['routineId'] ?? 0, // camelCase
      dayExercisesDescription: json['dayExercisesDescription'] ?? '', // camelCase
      exercises: (json['exercises'] as List<dynamic>?) // camelCase
              ?.map((e) => ExerciseDTO.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayName': dayName.index + 1, // camelCase
      'name': name,
      'routineId': routineId, // camelCase
      'dayExercisesDescription': dayExercisesDescription, // camelCase
      'exercises': exercises.map((e) => e.toJson()).toList(), // camelCase
    };
  }
}