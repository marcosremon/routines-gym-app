import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/stats/get_stats/get_stats_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/stats/set_daily_steps/set_daily_steps_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/stats/set_daily_steps/set_daily_steps_response.dart';
import 'package:routines_gym_app/infraestructure/repository/stats_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatsProvider extends ChangeNotifier {
  final StatsRepository statsRepository = StatsRepository();

  Future<SaveDailyStepsResponse> saveDailySteps(SaveDailyStepsRequest setDailyStepsRequest) async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setDailyStepsRequest.userEmail ??= prefs.getString("userEmail");
    return await statsRepository.saveDailySteps(setDailyStepsRequest);
  }

  Future<GetStatsResponse> getStats() async 
  {
    return await statsRepository.getStats();
  }
}