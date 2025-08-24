class AddExerciseRequest {
  String routineName;
  String exerciseName;
  String dayName;
  String? userEmail;

  AddExerciseRequest({
    this.routineName = '',
    this.exerciseName = '',
    this.dayName = '',
    this.userEmail,
  });

  factory AddExerciseRequest.fromJson(Map<String, dynamic> json) {
    return AddExerciseRequest(
      routineName: json['routineName'],
      exerciseName: json['exerciseName'] ?? '',
      dayName: json['dayName'] ?? '',
      userEmail: json['userEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'routineName': routineName,
        'exerciseName': exerciseName,
        'dayName': dayName,
        'userEmail': userEmail,
  };
}