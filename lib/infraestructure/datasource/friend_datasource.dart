import 'package:dio/dio.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/add_new_user_friend/add_new_user_friend_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/add_new_user_friend/add_new_user_friend_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/delete_friend/delete_friend_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/delete_friend/delete_friend_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/get_all_user_friends/get_all_user_friends_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/get_all_user_friends/get_all_user_friends_response.dart';
import 'package:routines_gym_app/configuration/constants/app_constants.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class FriendDatasource {

  final Dio dio = Dio();

  Future<GetAllUserFriendsResponse> getAllUserFrineds(GetAllUserFriendsRequest getAllUserFriendsRequest) async {
    GetAllUserFriendsResponse getAllUserFriendsResponse = GetAllUserFriendsResponse();
    try 
    {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.friendEndpoint}/get-all-user-friends',
        data: {
          'userEmail': getAllUserFriendsRequest.userEmail,
        },
      );

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCodeJson'] == 200) {
         getAllUserFriendsResponse.isSuccess = data['isSuccess'];
         getAllUserFriendsResponse.message = data['message'];
         getAllUserFriendsResponse.friends = data['friends'];
      } else {
         getAllUserFriendsResponse.isSuccess = false;
         getAllUserFriendsResponse.message = 'Error: ${response.statusMessage}';
      }      
    }
    catch (ex) 
    {
       getAllUserFriendsResponse.isSuccess = false;
       getAllUserFriendsResponse.message = 'unexpected error on FriendDatasource -> getAllUserFriends: ${ex.toString()}';
       ToastMessage.showToast("unexpected error");
    }

    return  getAllUserFriendsResponse;
  }

  Future<AddNewUserFriendResponse> addNewUserFriend(AddNewUserFriendRequest addNewUserFriendRequest) async {
    AddNewUserFriendResponse addNewUserFriendResponse = AddNewUserFriendResponse();
    try 
    {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.friendEndpoint}/add-new-user-friend',
        data: {
          'userEmail': addNewUserFriendRequest.userEmail,
          'friendCode': addNewUserFriendRequest.friendCode,
        },
      );

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCodeJson'] == 200) {
         addNewUserFriendResponse.isSuccess = data['isSuccess'];
         addNewUserFriendResponse.message = data['message'];
         addNewUserFriendResponse.friendId = data['friendId'];
      } else {
         addNewUserFriendResponse.isSuccess = false;
         addNewUserFriendResponse.message = 'Error: ${response.statusMessage}';
      }      
    }
    catch (ex) 
    {
       addNewUserFriendResponse.isSuccess = false;
       addNewUserFriendResponse.message = 'unexpected error on FriendDatasource -> addNewUserFriend: ${ex.toString()}';
       ToastMessage.showToast("unexpected error");
    }

    return  addNewUserFriendResponse;
  }

  Future<DeleteFriendResponse> deleteFriend(DeleteFriendRequest deleteFriendRequest) async {
    DeleteFriendResponse deleteFriendResponse = DeleteFriendResponse();
    try 
    {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.friendEndpoint}/delete-friend',
        data: {
          'userEmail': deleteFriendRequest.userEmail,
          'friendEmail': deleteFriendRequest.friendEmail,
        },
      );

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCodeJson'] == 200) {
        deleteFriendResponse.isSuccess = data['isSuccess'];
        deleteFriendResponse.message = data['message'];
      } else {
        deleteFriendResponse.isSuccess = false;
        deleteFriendResponse.message = 'Error: ${response.statusMessage}';
      }      
    }
    catch (ex) 
    {
      deleteFriendResponse.isSuccess = false;
      deleteFriendResponse.message = 'unexpected error on FriendDatasource -> deleteFriend: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return  deleteFriendResponse;
  }
}