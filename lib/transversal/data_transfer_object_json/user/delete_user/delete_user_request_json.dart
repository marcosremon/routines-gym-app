class DeleteUserRequestJson {
  String? email;

  DeleteUserRequestJson({this.email});

  factory DeleteUserRequestJson.fromJson(Map<String, dynamic> json) {
    return DeleteUserRequestJson(
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
