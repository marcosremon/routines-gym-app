class CheckTokenStatusRequestJson {
  String token;

  CheckTokenStatusRequestJson({this.token = ''});

  factory CheckTokenStatusRequestJson.fromJson(Map<String, dynamic> json) {
    return CheckTokenStatusRequestJson(
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}