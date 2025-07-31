class LoginRequest {
  String userEmail;
  String userPassword;

  LoginRequest({
    this.userEmail = '',
    this.userPassword = '',
  });

  Map<String, dynamic> toJson() => {
        'userEmail': userEmail,
        'userPassword': userPassword,
      };

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        userEmail: json['userEmail'] ?? '',
        userPassword: json['userPassword'] ?? '',
    );
}