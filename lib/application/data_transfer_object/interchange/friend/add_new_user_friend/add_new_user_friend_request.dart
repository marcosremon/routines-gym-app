class AddNewUserFriendRequest {
  String? userEmail;
  String friendCode;

  AddNewUserFriendRequest({
    this.userEmail,
    required this.friendCode,
  });

  factory AddNewUserFriendRequest.fromJson(Map<String, dynamic> json) {
    return AddNewUserFriendRequest(
      userEmail: json['userEmail'] ?? '',
      friendCode: json['friendCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'friendCode': friendCode,
    };
  }
}
