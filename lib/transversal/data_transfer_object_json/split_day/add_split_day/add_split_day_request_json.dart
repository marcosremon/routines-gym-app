import 'package:routines_gym_app/application/data_transfer_object/entities/exercise_dto.dart';

class AddSplitDayRequestJson {
  String? dayName;  // Cambiado a String? por simplicidad
  int? routineId;
  int? userId;
  List<ExerciseDTO> exercises;

  AddSplitDayRequestJson({
    this.dayName,
    this.routineId,
    this.userId,
    required this.exercises,
  });

  factory AddSplitDayRequestJson.fromJson(Map<String, dynamic> json) {
    return AddSplitDayRequestJson(
      dayName: json['dayName'],  // asumiendo que viene como String o null
      routineId: json['routineId'] != null ? (json['routineId'] as num).toInt() : null,
      userId: json['userId'] != null ? (json['userId'] as num).toInt() : null,
      exercises: (json['exercises'] as List<dynamic>? ?? [])
          .map((e) => ExerciseDTO.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayName': dayName,
      'routineId': routineId,
      'userId': userId,
      'exercises': exercises.map((e) => e.toJson()).toList(),
    };
  }
}
