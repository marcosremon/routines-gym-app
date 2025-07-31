class UpdateExerciseRequest {
  int? userId;
  int? routineId;
  String? dayName;
  String? exerciseName;
  int? sets;
  int? reps;
  double? weight;

  UpdateExerciseRequest({
    this.userId,
    this.routineId,
    this.dayName,
    this.exerciseName,
    this.sets,
    this.reps,
    this.weight,
  });

  factory UpdateExerciseRequest.fromJson(Map<String, dynamic> json) {
    return UpdateExerciseRequest(
      userId: json['userId'],
      routineId: json['routineId'],
      dayName: json['dayName'],
      exerciseName: json['exerciseName'],
      sets: json['sets'],
      reps: json['reps'],
      weight: (json['weight'] is int)
          ? (json['weight'] as int).toDouble()
          : json['weight'],
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'routineId': routineId,
        'dayName': dayName,
        'exerciseName': exerciseName,
        'sets': sets,
        'reps': reps,
        'weight': weight,
      };
  }