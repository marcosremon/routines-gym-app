class ExerciseProgress {
  final int progressId;
  final int exerciseId;
  final int routineId;
  final String dayName;
  final int sets;
  final int reps;
  final double weight;
  final DateTime performedAt;

  ExerciseProgress({
    required this.progressId,
    required this.exerciseId,
    required this.routineId,
    required this.dayName,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.performedAt,
  });

  factory ExerciseProgress.fromJson(Map<String, dynamic> json) => ExerciseProgress(
    progressId: json['progress_id'],
    exerciseId: json['exercise_id'],
    routineId: json['routine_id'],
    dayName: json['day_name'],
    sets: json['sets'],
    reps: json['reps'],
    weight: (json['weight'] as num).toDouble(),
    performedAt: DateTime.parse(json['performed_at']),
  );

  Map<String, dynamic> toJson() => {
    'progress_id': progressId,
    'exercise_id': exerciseId,
    'routine_id': routineId,
    'day_name': dayName,
    'sets': sets,
    'reps': reps,
    'weight': weight,
    'performed_at': performedAt.toIso8601String(),
  };
}