import 'package:flutter/foundation.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/get_all_user_friends/get_all_user_friends_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/get_all_user_friends/get_all_user_friends_response.dart';
import 'package:routines_gym_app/infraestructure/repository/friend_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendProvider extends ChangeNotifier {
  final FriendRepository friendRepository = FriendRepository();
  
  Future<GetAllUserFriendsResponse> getAllUserFriends() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GetAllUserFriendsRequest getAllUserFriendsRequest = GetAllUserFriendsRequest(
      userEmail: prefs.getString("userEmail") ?? "",
    );
    return await friendRepository.getAllUserFriends(getAllUserFriendsRequest);
  }

}