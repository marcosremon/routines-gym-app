class CreateGoogleUserRequest {
  String? dni;
  String? username;
  String? surname;
  String? email;
  String? password;
  String? confirmPassword;

  CreateGoogleUserRequest({
    this.dni,
    this.username,
    this.surname,
    this.email,
    this.password,
    this.confirmPassword,
  });

  factory CreateGoogleUserRequest.fromJson(Map<String, dynamic> json) {
    return CreateGoogleUserRequest(
      dni: json['dni'],
      username: json['username'],
      surname: json['surname'],
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dni': dni,
      'username': username,
      'surname': surname,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
