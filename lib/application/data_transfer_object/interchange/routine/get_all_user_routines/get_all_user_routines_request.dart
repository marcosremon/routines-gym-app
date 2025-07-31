class GetAllUserRoutinesRequest {
  String userEmail;

  GetAllUserRoutinesRequest({
    required this.userEmail,
  });

  factory GetAllUserRoutinesRequest.fromJson(Map<String, dynamic> json) {
    return GetAllUserRoutinesRequest(
      userEmail: json['userEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
    };
  }
}
