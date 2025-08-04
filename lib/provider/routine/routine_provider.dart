import 'package:flutter/foundation.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/create_routine/create_routine_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_stats/get_routine_stats_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_stats/get_routine_stats_response.dart';
import 'package:routines_gym_app/infraestructure/repository/routine_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoutineProvider extends ChangeNotifier {
  final RoutineRepository routineRepository = RoutineRepository();

  Future<GetRoutineStatsResponse> getRoutineStats() async 
  {
    GetRoutineStatsResponse getRoutineStatsResponse = GetRoutineStatsResponse();
    try
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = prefs.getString("userEmail") ?? "";
      GetRoutineStatsRequest getRoutineStatsRequest = GetRoutineStatsRequest(userEmail: email);

      GetRoutineStatsResponse getRoutineStatsResponseJson = await routineRepository.getRoutineStats(getRoutineStatsRequest);
      if (getRoutineStatsResponseJson.isSuccess) {
        getRoutineStatsResponse.routinesCount = getRoutineStatsResponseJson.routinesCount;
        getRoutineStatsResponse.exercisesCount = getRoutineStatsResponseJson.exercisesCount;
        getRoutineStatsResponse.splitsCount = getRoutineStatsResponseJson.splitsCount;
      }
      getRoutineStatsResponse.isSuccess = getRoutineStatsResponseJson.isSuccess;
      getRoutineStatsResponse.message = getRoutineStatsResponseJson.message ?? "";
    }
    catch (ex)
    {
      if (kDebugMode) {
        print("unexpected error on RoutineProvider -> getRoutineStats");
      }
    }

    return getRoutineStatsResponse;
  }
  
  
}