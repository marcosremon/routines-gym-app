class UpdateSplitDayRequestJson {
  int? routineId;
  String userEmail;
  List<String> addDays;
  List<String> deleteDays;

  UpdateSplitDayRequestJson({
    this.routineId,
    required this.userEmail,
    required this.addDays,
    required this.deleteDays,
  });

  factory UpdateSplitDayRequestJson.fromJson(Map<String, dynamic> json) {
    return UpdateSplitDayRequestJson(
      routineId: json['routineId'] != null ? (json['routineId'] as num).toInt() : null,
      userEmail: json['userEmail'] ?? '',
      addDays: List<String>.from(json['addDays'] ?? []),
      deleteDays: List<String>.from(json['deleteDays'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'routineId': routineId,
      'userEmail': userEmail,
      'addDays': addDays,
      'deleteDays': deleteDays,
    };
  }
}
