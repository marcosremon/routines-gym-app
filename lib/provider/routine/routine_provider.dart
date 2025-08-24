import 'package:flutter/foundation.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/create_routine/create_routine_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/create_routine/create_routine_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/delete_routine/delete_routine_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/delete_routine/delete_routine_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_all_user_routines/get_all_user_routines_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_all_user_routines/get_all_user_routines_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_by_id/get_routine_by_id_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_by_id/get_routine_by_id_response.dart';
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

  Future<GetAllUserRoutinesResponse> getAllUserRoutines(GetAllUserRoutinesRequest getAllUserRoutinesRequest) async 
  {
    return await routineRepository.getAllUserRoutines(getAllUserRoutinesRequest);
  }

  Future<GetRoutineByRoutineNameResponse> getRoutineByRoutineName(GetRoutineByRoutineNameRequest getRoutineByRoutineNameRequest) async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getRoutineByRoutineNameRequest.userEmail ??= prefs.getString("userEmail");
    return await routineRepository.getRoutineByRoutineName(getRoutineByRoutineNameRequest);
  }

  Future<DeleteRoutineResponse> deleteRoutine(DeleteRoutineRequest deleteRoutineRequest) async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    deleteRoutineRequest.userEmail ??= prefs.getString("userEmail");
    return await routineRepository.deleteRoutine(deleteRoutineRequest);
  }  
}