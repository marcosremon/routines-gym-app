class CreateNewPasswordRequest {
  String userEmail;

  CreateNewPasswordRequest({
    required this.userEmail,
  });

  factory CreateNewPasswordRequest.fromJson(Map<String, dynamic> json) {
    return CreateNewPasswordRequest(
      userEmail: json['userEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
    };
  }
}
