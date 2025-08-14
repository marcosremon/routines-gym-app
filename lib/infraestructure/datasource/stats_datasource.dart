import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/stats/set_daily_steps/set_daily_steps_request.dart';
import 'package:routines_gym_app/configuration/constants/app_constants.dart';

class StatsDatasource {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> setDailySteps(SetDailyStepsRequest setDailyStepsRequest) async 
  {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.statsEndpoint}/set-daily-steps',
        data: {
          'steps': setDailyStepsRequest.steps,
          'limitStepsPerDay': setDailyStepsRequest.limitStepsPerDay,
          'date': setDailyStepsRequest.date,
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
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.statsEndpoint}/get-stats',
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