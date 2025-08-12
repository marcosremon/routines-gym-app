class ExerciseDTO {
  String exerciseName;
  int routineId;
  int splitDayId;

  ExerciseDTO({
    required this.exerciseName,
    required this.routineId,
    required this.splitDayId,
  });

  factory ExerciseDTO.fromJson(Map<String, dynamic> json) {
    return ExerciseDTO(
      exerciseName: json['ExerciseName'] ?? '',
      routineId: json['RoutineId'] ?? 0,
      splitDayId: json['SplitDayId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ExerciseName': exerciseName,
      'RoutineId': routineId,
      'SplitDayId': splitDayId,
    };
  }
}