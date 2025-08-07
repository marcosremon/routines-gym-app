// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/split_day/delete_split_day/delete_split_day_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/split_day/update_split_day/update_split_day_request.dart';
import 'package:routines_gym_app/configuration/constants/app_constants.dart';

class SplitDayDatasource {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> updateSplitDay(UpdateSplitDayRequest updateSplitDayRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.splitDayEndpoint}/update-split-day',
        data: {
          'routineId': updateSplitDayRequest.routineId,
          'userEmail': updateSplitDayRequest.userEmail,
          'addDays': updateSplitDayRequest.addDays,
          'deleteDays': updateSplitDayRequest.deleteDays,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> deleteSplitDay(DeleteSplitDayRequest deleteSplitDayRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.splitDayEndpoint}/delete-split-day',
        data: {
          'dayName': deleteSplitDayRequest.dayName,
          'routineId': deleteSplitDayRequest.routineId,
          'userId': deleteSplitDayRequest.userId,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }

    return data;
  }
}