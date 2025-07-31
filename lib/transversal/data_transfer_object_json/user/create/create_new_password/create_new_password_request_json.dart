class CreateNewPasswordRequestJson {
  String userEmail;

  CreateNewPasswordRequestJson({
    required this.userEmail,
  });

  factory CreateNewPasswordRequestJson.fromJson(Map<String, dynamic> json) {
    return CreateNewPasswordRequestJson(
      userEmail: json['userEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
    };
  }
}
