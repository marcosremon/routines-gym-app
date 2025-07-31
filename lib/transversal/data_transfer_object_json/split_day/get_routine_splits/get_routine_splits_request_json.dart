class GetRoutineSplitsRequestJson {
  int routineId;

  GetRoutineSplitsRequestJson({required this.routineId});

  factory GetRoutineSplitsRequestJson.fromJson(Map<String, dynamic> json) {
    return GetRoutineSplitsRequestJson(
      routineId: (json['routineId'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'routineId': routineId,
    };
  }
}
