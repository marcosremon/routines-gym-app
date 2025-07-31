class GetAllUserFriendsRequest {
  String userEmail;

  GetAllUserFriendsRequest({
    required this.userEmail,
  });

  factory GetAllUserFriendsRequest.fromJson(Map<String, dynamic> json) {
    return GetAllUserFriendsRequest(
      userEmail: json['userEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
    };
  }
}
