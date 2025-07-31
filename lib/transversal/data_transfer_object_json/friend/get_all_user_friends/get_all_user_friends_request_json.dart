class GetAllUserFriendsRequestJson {
  String userEmail;

  GetAllUserFriendsRequestJson({
    required this.userEmail,
  });

  factory GetAllUserFriendsRequestJson.fromJson(Map<String, dynamic> json) {
    return GetAllUserFriendsRequestJson(
      userEmail: json['userEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
    };
  }
}
