import 'package:flutter/foundation.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/add_new_user_friend/add_new_user_friend_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/add_new_user_friend/add_new_user_friend_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/delete_friend/delete_friend_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/delete_friend/delete_friend_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/get_all_user_friends/get_all_user_friends_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/get_all_user_friends/get_all_user_friends_response.dart';
import 'package:routines_gym_app/infraestructure/repository/friend_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendProvider extends ChangeNotifier {
  final FriendRepository friendRepository = FriendRepository();
  
  Future<GetAllUserFriendsResponse> getAllUserFriends() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GetAllUserFriendsRequest getAllUserFriendsRequest = GetAllUserFriendsRequest(
      userEmail: prefs.getString("userEmail") ?? "juan.perez@example.com",
    );
    GetAllUserFriendsResponse getAllUserFriendsResponse = await friendRepository.getAllUserFriends(getAllUserFriendsRequest);
    return getAllUserFriendsResponse;
  }

  Future<AddNewUserFriendResponse> addNewUserFriend(AddNewUserFriendRequest addNewUserFriendRequest) async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    addNewUserFriendRequest.userEmail = prefs.getString("userEmail") ?? "";
    return await friendRepository.addNewUserFriend(addNewUserFriendRequest);
  }

  Future<DeleteFriendResponse> removeFriend(DeleteFriendRequest deleteFriendRequest) async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    deleteFriendRequest.userEmail = prefs.getString("userEmail") ?? "";
    return await friendRepository.removeFriend(deleteFriendRequest);
  }
}