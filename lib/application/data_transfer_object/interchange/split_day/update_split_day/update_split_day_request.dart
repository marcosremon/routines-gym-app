class UpdateSplitDayRequest {
  String? routineName;
  String userEmail;
  List<String> addDays;
  List<String> deleteDays;

  UpdateSplitDayRequest({
    this.routineName,
    required this.userEmail,
    required this.addDays,
    required this.deleteDays,
  });

  factory UpdateSplitDayRequest.fromJson(Map<String, dynamic> json) {
    return UpdateSplitDayRequest(
      routineName: json['routineName'],
      userEmail: json['userEmail'] ?? '',
      addDays: List<String>.from(json['addDays'] ?? []),
      deleteDays: List<String>.from(json['deleteDays'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'routineName': routineName,
      'userEmail': userEmail,
      'addDays': addDays,
      'deleteDays': deleteDays,
    };
  }
}
