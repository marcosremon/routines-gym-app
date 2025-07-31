class AddExerciseAddExerciseProgressRequestJson {
  List<String> progressList;
  String userEmail;
  int? routineId;
  String dayName;

  AddExerciseAddExerciseProgressRequestJson({
    this.progressList = const [],
    this.userEmail = '',
    this.routineId,
    this.dayName = '',
  });

  factory AddExerciseAddExerciseProgressRequestJson.fromJson(Map<String, dynamic> json) {
    return AddExerciseAddExerciseProgressRequestJson(
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