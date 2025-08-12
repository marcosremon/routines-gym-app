import 'package:flutter/foundation.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/create_routine/create_routine_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/create_routine/create_routine_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_stats/get_routine_stats_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_stats/get_routine_stats_response.dart';
import 'package:routines_gym_app/infraestructure/repository/routine_repository.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoutineProvider extends ChangeNotifier {
  final RoutineRepository routineRepository = RoutineRepository();

  Future<GetRoutineStatsResponse> getRoutineStats() async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GetRoutineStatsRequest getRoutineStatsRequest = GetRoutineStatsRequest(
      userEmail: prefs.getString("userEmail") ?? ""
    );
    notifyListeners(); 
    return await routineRepository.getRoutineStats(getRoutineStatsRequest);
  }

  Future<void> createRoutine(CreateRoutineRequest createRoutineRequest) async 
  {
    CreateRoutineResponse createRoutineResponse = await routineRepository.createRoutine(createRoutineRequest);
    ToastMessage.showToast(createRoutineResponse.message!);
  }
  
  
}