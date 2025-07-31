class AddNewUserFriendRequestJson {
  String userEmail;
  String friendCode;

  AddNewUserFriendRequestJson({
    required this.userEmail,
    required this.friendCode,
  });

  factory AddNewUserFriendRequestJson.fromJson(Map<String, dynamic> json) {
    return AddNewUserFriendRequestJson(
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
