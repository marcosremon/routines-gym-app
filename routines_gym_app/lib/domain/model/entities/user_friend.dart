class UserFriend {
  final int userFriendId;
  final int userId;
  final int friendId;

  UserFriend({
    required this.userFriendId,
    required this.userId,
    required this.friendId,
  });

  factory UserFriend.fromJson(Map<String, dynamic> json) => UserFriend(
    userFriendId: json['user_friend_id'],
    userId: json['user_id'],
    friendId: json['friend_id'],
  );

  Map<String, dynamic> toJson() => {
    'user_friend_id': userFriendId,
    'user_id': userId,
    'friend_id': friendId,
  };
}