class UserFriendDTO {
  int userId;
  int friendId;

  UserFriendDTO({
    required this.userId,
    required this.friendId,
  });

  factory UserFriendDTO.fromJson(Map<String, dynamic> json) {
    return UserFriendDTO(
      userId: json['userId'] ?? 0,
      friendId: json['friendId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'friendId': friendId,
    };
  }
}
