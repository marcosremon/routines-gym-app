class AddExerciseProgressRequest {
  List<String> progressList;
  String userEmail;
  int? routineId;
  String dayName;

  AddExerciseProgressRequest({
    this.progressList = const [],
    this.userEmail = '',
    this.routineId,
    this.dayName = '',
  });

  factory AddExerciseProgressRequest.fromJson(Map<String, dynamic> json) {
    return AddExerciseProgressRequest(
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