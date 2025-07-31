class DeleteFriendRequest {
  String userEmail;
  String friendEmail;

  DeleteFriendRequest({
    required this.userEmail,
    required this.friendEmail,
  });

  factory DeleteFriendRequest.fromJson(Map<String, dynamic> json) {
    return DeleteFriendRequest(
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
