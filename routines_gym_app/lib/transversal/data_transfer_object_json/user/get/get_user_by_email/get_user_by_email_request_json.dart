class GetUserByEmailRequestJson {
  String email;

  GetUserByEmailRequestJson({required this.email});

  factory GetUserByEmailRequestJson.fromJson(Map<String, dynamic> json) {
    return GetUserByEmailRequestJson(
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
