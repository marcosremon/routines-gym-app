class Exercise {
  final int exerciseId;
  final String exerciseName;
  final int routineId;
  final int splitDayId;

  Exercise({
    required this.exerciseId,
    required this.exerciseName,
    required this.routineId,
    required this.splitDayId,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    exerciseId: json['exercise_id'],
    exerciseName: json['exercise_name'],
    routineId: json['routine_id'],
    splitDayId: json['split_day_id'],
  );

  Map<String, dynamic> toJson() => {
    'exercise_id': exerciseId,
    'exercise_name': exerciseName,
    'routine_id': routineId,
    'split_day_id': splitDayId,
  };
}