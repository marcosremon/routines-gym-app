class GetExercisesByDayAndRoutineIdRequest {
  String? routineName;
  String? dayName;

  GetExercisesByDayAndRoutineIdRequest({
    this.routineName,
    this.dayName,
  });

  factory GetExercisesByDayAndRoutineIdRequest.fromJson(Map<String, dynamic> json) {
    return GetExercisesByDayAndRoutineIdRequest(
      routineName: json['routineId'],
      dayName: json['dayName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'routineId': routineName,
        'dayName': dayName,
      };
}