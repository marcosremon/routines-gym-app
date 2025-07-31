class AddExerciseAddExerciseProgressRequest {
  List<String> progressList;
  String userEmail;
  int? routineId;
  String dayName;

  AddExerciseAddExerciseProgressRequest({
    this.progressList = const [],
    this.userEmail = '',
    this.routineId,
    this.dayName = '',
  });

  factory AddExerciseAddExerciseProgressRequest.fromJson(Map<String, dynamic> json) {
    return AddExerciseAddExerciseProgressRequest(
      progressList: (json['progressList'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      userEmail: json['userEmail'] ?? '',
      routineId: json['routineId'],
      dayName: json['dayName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'progressList': progressList,
        'userEmail': userEmail,
        'routineId': routineId,
        'dayName': dayName,
      };
}