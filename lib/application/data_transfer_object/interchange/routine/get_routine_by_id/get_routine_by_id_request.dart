class GetRoutineByIdRequest {
  int? routineId;

  GetRoutineByIdRequest({
    this.routineId,
  });

  factory GetRoutineByIdRequest.fromJson(Map<String, dynamic> json) {
    return GetRoutineByIdRequest(
      routineId: json['routineId'] != null ? (json['routineId'] as num).toInt() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'routineId': routineId,
    };
  }
}
