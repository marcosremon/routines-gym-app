import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/stats/set_daily_steps/set_daily_steps_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/stats/set_daily_steps/set_daily_steps_response.dart';
import 'package:routines_gym_app/infraestructure/repository/stats_repository.dart';

class StatsProvider extends ChangeNotifier {
  final StatsRepository statsRepository = StatsRepository();

  Future<SetDailyStepsResponse> setDailySteps(SetDailyStepsRequest setDailyStepsRequest) async 
  {
    return await statsRepository.setDailySteps(setDailyStepsRequest);
  }

}