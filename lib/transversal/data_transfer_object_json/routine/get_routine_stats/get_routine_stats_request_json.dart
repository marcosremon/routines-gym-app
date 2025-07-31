class GetRoutineStatsRequestJson {
  String userEmail;

  GetRoutineStatsRequestJson({
    required this.userEmail,
  });

  factory GetRoutineStatsRequestJson.fromJson(Map<String, dynamic> json) {
    return GetRoutineStatsRequestJson(
      userEmail: json['userEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
    };
  }
}
