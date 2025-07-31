class DeleteFriendRequestJson {
  String userEmail;
  String friendEmail;

  DeleteFriendRequestJson({
    required this.userEmail,
    required this.friendEmail,
  });

  factory DeleteFriendRequestJson.fromJson(Map<String, dynamic> json) {
    return DeleteFriendRequestJson(
      userEmail: json['userEmail'] ?? '',
      friendEmail: json['friendEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'friendEmail': friendEmail,
    };
  }
}
