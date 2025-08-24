class DeleteExerciseRequest {
  String? userEmail;
  int? routineId;
  String? dayName;
  String? exerciseName;

  DeleteExerciseRequest({
    this.userEmail,
    this.routineId,
    this.dayName,
    this.exerciseName,
  });

  factory DeleteExerciseRequest.fromJson(Map<String, dynamic> json) {
    return DeleteExerciseRequest(
      userEmail: json['userEmail'] ?? '',
      routineId: json['routineId'],
      dayName: json['dayName'],
      exerciseName: json['exerciseName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'userEmail': userEmail,
        'routineId': routineId,
        'dayName': dayName,
        'exerciseName': exerciseName,
      };
}