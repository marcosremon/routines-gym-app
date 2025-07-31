class DeleteExerciseRequest {
  String userEmail;
  int? routineId;
  String? dayName;
  int? exerciseId;

  DeleteExerciseRequest({
    this.userEmail = '',
    this.routineId,
    this.dayName,
    this.exerciseId,
  });

  factory DeleteExerciseRequest.fromJson(Map<String, dynamic> json) {
    return DeleteExerciseRequest(
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