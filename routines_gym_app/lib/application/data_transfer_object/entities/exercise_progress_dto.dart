import 'package:routines_gym_app/domain/model/enums/week_day.dart';

class ExerciseProgressDTO {
  int exerciseId;
  int routineId;
  WeekDay dayName;
  int sets;
  int reps;
  double weight;
  DateTime performedAt;

  ExerciseProgressDTO({
    required this.exerciseId,
    required this.routineId,
    required this.dayName,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.performedAt,
  });

  factory ExerciseProgressDTO.fromJson(Map<String, dynamic> json) {
    return ExerciseProgressDTO(
      exerciseId: json['exerciseId'] ?? 0,
      routineId: json['routineId'] ?? 0,
      dayName: WeekDay.values.firstWhere(
        (e) => e.name.toLowerCase() == (json['dayName'] ?? '').toLowerCase(),
        orElse: () => WeekDay.monday,
      ),
      sets: json['sets'] ?? 0,
      reps: json['reps'] ?? 0,
      weight: (json['weight'] ?? 0).toDouble(),
      performedAt: DateTime.parse(json['performedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'routineId': routineId,
      'dayName': dayName.name,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'performedAt': performedAt.toIso8601String(),
    };
  }
}