class GetRoutineSplitsRequest {
  int routineId;

  GetRoutineSplitsRequest({required this.routineId});

  factory GetRoutineSplitsRequest.fromJson(Map<String, dynamic> json) {
    return GetRoutineSplitsRequest(
      routineId: (json['routineId'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'routineId': routineId,
    };
  }
}
