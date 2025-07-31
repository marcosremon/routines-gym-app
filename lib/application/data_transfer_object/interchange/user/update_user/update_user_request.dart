class UpdateUserRequest {
  String? originalEmail;
  String? dniToBeFound;
  String? username;
  String? surname;
  String? email;

  UpdateUserRequest({
    this.originalEmail,
    this.dniToBeFound,
    this.username,
    this.surname,
    this.email,
  });

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) {
    return UpdateUserRequest(
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
