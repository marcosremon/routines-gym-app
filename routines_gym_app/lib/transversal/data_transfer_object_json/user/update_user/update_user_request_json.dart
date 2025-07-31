class UpdateUserRequestJson {
  String? originalEmail;
  String? dniToBeFound;
  String? username;
  String? surname;
  String? email;

  UpdateUserRequestJson({
    this.originalEmail,
    this.dniToBeFound,
    this.username,
    this.surname,
    this.email,
  });

  factory UpdateUserRequestJson.fromJson(Map<String, dynamic> json) {
    return UpdateUserRequestJson(
      originalEmail: json['originalEmail'],
      dniToBeFound: json['dniToBeFound'],
      username: json['username'],
      surname: json['surname'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'originalEmail': originalEmail,
      'dniToBeFound': dniToBeFound,
      'username': username,
      'surname': surname,
      'email': email,
    };
  }
}
