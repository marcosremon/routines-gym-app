class ChangePasswordWithPasswordAndEmailRequest {
  String? userEmail;
  String? oldPassword;
  String? newPassword;
  String? confirmNewPassword;

  ChangePasswordWithPasswordAndEmailRequest({
    this.userEmail,
    this.oldPassword,
    this.newPassword,
    this.confirmNewPassword,
  });

  factory ChangePasswordWithPasswordAndEmailRequest.fromJson(Map<String, dynamic> json) {
    return ChangePasswordWithPasswordAndEmailRequest(
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
