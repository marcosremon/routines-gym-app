class AddExerciseRequest {
  int? routineId;
  String exerciseName;
  String dayName;
  String userEmail;
  int sets;
  int reps;
  double weight;

  AddExerciseRequest({
    this.routineId,
    this.exerciseName = '',
    this.dayName = '',
    this.userEmail = '',
    this.sets = 0,
    this.reps = 0,
    this.weight = 0.0,
  });

  factory AddExerciseRequest.fromJson(Map<String, dynamic> json) {
    return AddExerciseRequest(
      routineId: json['routineId'],
      exerciseName: json['exerciseName'] ?? '',
      dayName: json['dayName'] ?? '',
      userEmail: json['userEmail'] ?? '',
      sets: json['sets'] ?? 0,
      reps: json['reps'] ?? 0,
      weight: (json['weight'] is int)
          ? (json['weight'] as int).toDouble()
          : (json['weight'] ?? 0.0),
    );
  }

  Map<String, dynamic> toJson() => {
        'routineId': routineId,
        'exerciseName': exerciseName,
        'dayName': dayName,
        'userEmail': userEmail,
        'sets': sets,
        'reps': reps,
        'weight': weight,
  };
}