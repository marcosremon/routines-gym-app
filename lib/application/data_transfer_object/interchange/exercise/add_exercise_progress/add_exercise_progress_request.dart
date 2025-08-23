class AddExerciseProgressRequest {
  List<String> progressList;
  String? userEmail;
  int? routineId;
  int? splitDayId;
  String? exerciseName;

  AddExerciseProgressRequest({
    this.progressList = const [],
    this.userEmail,
    this.routineId,
    this.splitDayId,
    this.exerciseName,
  });

  factory AddExerciseProgressRequest.fromJson(Map<String, dynamic> json) {
    return AddExerciseProgressRequest(
      progressList: (json['progressList'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      userEmail: json['userEmail'],
      routineId: json['routineId'],
      splitDayId: json['splitDayId'],
      exerciseName: json['exerciseName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'progressList': progressList,
        'userEmail': userEmail,
        'routineId': routineId,
        'splitDayId': splitDayId,
        'exerciseName': exerciseName,
      };
}