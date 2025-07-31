class GetUserByEmailRequest {
  String email;

  GetUserByEmailRequest({required this.email});

  factory GetUserByEmailRequest.fromJson(Map<String, dynamic> json) {
    return GetUserByEmailRequest(
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
