// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/add_new_user_friend/add_new_user_friend_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/delete_friend/delete_friend_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/get_all_user_friends/get_all_user_friends_request.dart';
import 'package:routines_gym_app/configuration/constants/app_constants.dart';

class FriendDatasource {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> getAllUserFriends(GetAllUserFriendsRequest request) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.friendEndpoint}/get-all-user-friends',
        data: {
          'userEmail': request.userEmail,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> addNewUserFriend(AddNewUserFriendRequest request) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.friendEndpoint}/add-new-user-friend',
        data: {
          'userEmail': request.userEmail,
          'friendCode': request.friendCode,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> deleteFriend(DeleteFriendRequest request) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.friendEndpoint}/delete-friend',
        data: {
          'userEmail': request.userEmail,
          'friendEmail': request.friendEmail,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }

    return data;
  }
}