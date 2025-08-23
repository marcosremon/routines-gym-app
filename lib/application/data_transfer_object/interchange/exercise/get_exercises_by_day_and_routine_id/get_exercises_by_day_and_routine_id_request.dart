class GetExercisesByDayAndRoutineNameRequest {
  String? routineName;
  String? dayName;
  String? userEmail; 

  GetExercisesByDayAndRoutineNameRequest({
    this.routineName,
    this.dayName,
    this.userEmail,
  });

  factory GetExercisesByDayAndRoutineNameRequest.fromJson(Map<String, dynamic> json) {
    return GetExercisesByDayAndRoutineNameRequest(
      routineName: json['routineName'],
      dayName: json['dayName'],
      userEmail: json['userEmail'], 
    );
  }

  Map<String, dynamic> toJson() => {
        'routineName': routineName,
        'dayName': dayName,
        'userEmail': userEmail, 
      };
}
