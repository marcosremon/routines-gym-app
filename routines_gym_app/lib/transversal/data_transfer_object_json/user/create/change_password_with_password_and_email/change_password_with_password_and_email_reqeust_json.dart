class ChangePasswordWithPasswordAndEmailRequestJson {
  String? userEmail;
  String? oldPassword;
  String? newPassword;
  String? confirmNewPassword;

  ChangePasswordWithPasswordAndEmailRequestJson({
    this.userEmail,
    this.oldPassword,
    this.newPassword,
    this.confirmNewPassword,
  });

  factory ChangePasswordWithPasswordAndEmailRequestJson.fromJson(Map<String, dynamic> json) {
    return ChangePasswordWithPasswordAndEmailRequestJson(
      userEmail: json['userEmail'],
      oldPassword: json['oldPassword'],
      newPassword: json['newPassword'],
      confirmNewPassword: json['confirmNewPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
    };
  }
}
