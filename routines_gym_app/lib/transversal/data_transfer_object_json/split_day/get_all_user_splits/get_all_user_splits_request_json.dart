class GetAllUserSplitsRequestJson {
  int? userId;

  GetAllUserSplitsRequestJson({this.userId});

  factory GetAllUserSplitsRequestJson.fromJson(Map<String, dynamic> json) {
    return GetAllUserSplitsRequestJson(
      userId: json['userId'] != null ? (json['userId'] as num).toInt() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
    };
  }
}
