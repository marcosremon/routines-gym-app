class GetAllUserRoutinesRequestJson {
  String userEmail;

  GetAllUserRoutinesRequestJson({
    required this.userEmail,
  });

  factory GetAllUserRoutinesRequestJson.fromJson(Map<String, dynamic> json) {
    return GetAllUserRoutinesRequestJson(
      userEmail: json['userEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
    };
  }
}
