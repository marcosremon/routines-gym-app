class GetExercisesByDayAndRoutineIdRequestJson {
  int? routineId;
  String? dayName;

  GetExercisesByDayAndRoutineIdRequestJson({
    this.routineId,
    this.dayName,
  });

  factory GetExercisesByDayAndRoutineIdRequestJson.fromJson(Map<String, dynamic> json) {
    return GetExercisesByDayAndRoutineIdRequestJson(
      routineId: json['routineId'],
      dayName: json['dayName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'routineId': routineId,
        'dayName': dayName,
      };
}