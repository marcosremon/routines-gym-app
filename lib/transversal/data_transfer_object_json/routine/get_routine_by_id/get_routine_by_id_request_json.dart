class GetRoutineByIdRequestJson {
  int? routineId;

  GetRoutineByIdRequestJson({
    this.routineId,
  });

  factory GetRoutineByIdRequestJson.fromJson(Map<String, dynamic> json) {
    return GetRoutineByIdRequestJson(
      routineId: json['routineId'] != null ? (json['routineId'] as num).toInt() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'routineId': routineId,
    };
  }
}
