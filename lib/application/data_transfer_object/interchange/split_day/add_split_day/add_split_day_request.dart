import 'package:routines_gym_app/application/data_transfer_object/entities/exercise_dto.dart';

class AddSplitDayRequest {
  String? dayName;  
  int? routineId;
  int? userId;
  List<ExerciseDTO> exercises;

  AddSplitDayRequest({
    this.dayName,
    this.routineId,
    this.userId,
    required this.exercises,
  });

  factory AddSplitDayRequest.fromJson(Map<String, dynamic> json) {
    return AddSplitDayRequest(
      dayName: json['dayName'], 
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
