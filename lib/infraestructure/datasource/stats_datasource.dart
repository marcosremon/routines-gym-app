import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/stats/set_daily_steps/set_daily_steps_request.dart';
import 'package:routines_gym_app/configuration/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatsDatasource {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> saveDailySteps(SaveDailyStepsRequest setDailyStepsRequest) async 
  {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.statsEndpoint}/save-daily-steps',
        data: {
          'steps': setDailyStepsRequest.steps,
          'userEmail': setDailyStepsRequest.userEmail,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      if (kDebugMode) {
        print("unexpected error");
      }
    }

    return data;
  }

  Future<Map<String, dynamic>> getStats() async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.statsEndpoint}/get-stats',
        data: {
          'userEmail': prefs.getString("userEmail"),
        },
      );
      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      if (kDebugMode) {
        print("unexpected error");
      }
    }
    return data;
  } 
}