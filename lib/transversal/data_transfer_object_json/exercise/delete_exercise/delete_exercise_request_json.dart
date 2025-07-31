class DeleteExerciseRequestJson {
  String userEmail;
  int? routineId;
  String? dayName;
  int? exerciseId;

  DeleteExerciseRequestJson({
    this.userEmail = '',
    this.routineId,
    this.dayName,
    this.exerciseId,
  });

  factory DeleteExerciseRequestJson.fromJson(Map<String, dynamic> json) {
    return DeleteExerciseRequestJson(
      userEmail: json['userEmail'] ?? '',
      routineId: json['routineId'],
      dayName: json['dayName'],
      exerciseId: json['exerciseId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'userEmail': userEmail,
        'routineId': routineId,
        'dayName': dayName,
        'exerciseId': exerciseId,
      };
}