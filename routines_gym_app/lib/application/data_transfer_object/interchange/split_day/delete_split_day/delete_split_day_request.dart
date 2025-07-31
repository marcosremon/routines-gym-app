class DeleteSplitDayRequest {
  String? dayName;
  int? routineId;
  int? userId;

  DeleteSplitDayRequest({
    this.dayName,
    this.routineId,
    this.userId,
  });

  factory DeleteSplitDayRequest.fromJson(Map<String, dynamic> json) {
    return DeleteSplitDayRequest(
      dayName: json['dayName'],
      routineId: json['routineId'] != null ? (json['routineId'] as num).toInt() : null,
      userId: json['userId'] != null ? (json['userId'] as num).toInt() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayName': dayName,
      'routineId': routineId,
      'userId': userId,
    };
  }
}
