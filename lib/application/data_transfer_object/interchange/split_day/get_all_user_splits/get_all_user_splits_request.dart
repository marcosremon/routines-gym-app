class GetAllUserSplitsRequest {
  int? userId;

  GetAllUserSplitsRequest({this.userId});

  factory GetAllUserSplitsRequest.fromJson(Map<String, dynamic> json) {
    return GetAllUserSplitsRequest(
      userId: json['userId'] != null ? (json['userId'] as num).toInt() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
    };
  }
}
