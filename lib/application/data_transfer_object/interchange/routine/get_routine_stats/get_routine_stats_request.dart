class GetRoutineStatsRequest {
  String userEmail;

  GetRoutineStatsRequest({
    required this.userEmail,
  });

  factory GetRoutineStatsRequest.fromJson(Map<String, dynamic> json) {
    return GetRoutineStatsRequest(
      userEmail: json['userEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
    };
  }
}
