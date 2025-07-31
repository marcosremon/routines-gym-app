class LoginRequestJson {
  String userEmail;
  String userPassword;

  LoginRequestJson({
    this.userEmail = '',
    this.userPassword = '',
  });

  Map<String, dynamic> toJson() => {
        'userEmail': userEmail,
        'userPassword': userPassword,
      };

  factory LoginRequestJson.fromJson(Map<String, dynamic> json) => LoginRequestJson(
        userEmail: json['userEmail'] ?? '',
        userPassword: json['userPassword'] ?? '',
    );
}