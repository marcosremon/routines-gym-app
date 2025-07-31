class GetExercisesByDayAndRoutineIdRequest {
  int? routineId;
  String? dayName;

  GetExercisesByDayAndRoutineIdRequest({
    this.routineId,
    this.dayName,
  });

  factory GetExercisesByDayAndRoutineIdRequest.fromJson(Map<String, dynamic> json) {
    return GetExercisesByDayAndRoutineIdRequest(
      routineId: json['routineId'],
      dayName: json['dayName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'routineId': routineId,
        'dayName': dayName,
      };
}