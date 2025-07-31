class CheckTokenStatusRequest {
  String token;

  CheckTokenStatusRequest({this.token = ''});

  factory CheckTokenStatusRequest.fromJson(Map<String, dynamic> json) {
    return CheckTokenStatusRequest(
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}