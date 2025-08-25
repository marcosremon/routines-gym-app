import 'package:flutter/foundation.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/add_new_user_friend/add_new_user_friend_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/add_new_user_friend/add_new_user_friend_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/delete_friend/delete_friend_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/delete_friend/delete_friend_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/get_all_user_friends/get_all_user_friends_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/get_all_user_friends/get_all_user_friends_response.dart';
import 'package:routines_gym_app/infraestructure/datasource/friend_datasource.dart';
import 'package:routines_gym_app/transversal/common/response_codes.dart';

class FriendRepository {
  final FriendDatasource friendDatasource = FriendDatasource();

  Future<GetAllUserFriendsResponse> getAllUserFriends(GetAllUserFriendsRequest getAllUserFriendsRequest) async
  {
    GetAllUserFriendsResponse getAllUserFriendsResponse = GetAllUserFriendsResponse();
    try 
    {
      Map<String, dynamic> data = await friendDatasource.getAllUserFriends(getAllUserFriendsRequest);
       if (data['responseCodeJson'] == 200) {
        getAllUserFriendsResponse.isSuccess = data['isSuccess'];
        getAllUserFriendsResponse.message = data['message'];
        getAllUserFriendsResponse.friends = (data['friends'] as List)
          .map((item) => UserDTO.fromJson(item))
          .toList();
      } else {
        getAllUserFriendsResponse.isSuccess = false;
        getAllUserFriendsResponse.message = 'Error: ${data['message']}';
      }
      getAllUserFriendsResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    }
    catch (e) {
      if (kDebugMode) {
        print("Error fetching friends: $e");
      }
      getAllUserFriendsResponse.isSuccess = false;
      getAllUserFriendsResponse.message = "Failed to fetch friends";
      getAllUserFriendsResponse.friends = [];
    }

    return getAllUserFriendsResponse;
  }

  Future<AddNewUserFriendResponse> addNewUserFriend(AddNewUserFriendRequest addNewUserFriendRequest) async 
  {
    AddNewUserFriendResponse addNewUserFriendResponse = AddNewUserFriendResponse();
    try 
    {
      Map<String, dynamic> data = await friendDatasource.addNewUserFriend(addNewUserFriendRequest);
      if (data['responseCodeJson'] == 200) {
        addNewUserFriendResponse.isSuccess = data['isSuccess'];
        addNewUserFriendResponse.message = data['message'];
      } else {
        addNewUserFriendResponse.isSuccess = false;
        addNewUserFriendResponse.message = 'Error: ${data['message']}';
      }
      addNewUserFriendResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } 
    catch (e) {
      if (kDebugMode) {
        print("Error adding new friend: $e");
      }
      addNewUserFriendResponse.isSuccess = false;
      addNewUserFriendResponse.message = "Failed to add new friend";
    }

    return addNewUserFriendResponse;
  }

  Future<DeleteFriendResponse> removeFriend(DeleteFriendRequest deleteFriendRequest) async 
  {
    DeleteFriendResponse deleteFriendResponse = DeleteFriendResponse();
    try 
    {
      Map<String, dynamic> data = await friendDatasource.removeFriend(deleteFriendRequest);
      if (data['responseCodeJson'] == 200) {
        deleteFriendResponse.isSuccess = data['isSuccess'];
        deleteFriendResponse.message = data['message'];
      } else {
        deleteFriendResponse.isSuccess = false;
        deleteFriendResponse.message = 'Error: ${data['message']}';
      }
      deleteFriendResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } 
    catch (e) {
      if (kDebugMode) {
        print("Error adding new friend: $e");
      }
      deleteFriendResponse.isSuccess = false;
      deleteFriendResponse.message = "Failed to add new friend";
    }

    return deleteFriendResponse;
  }
}