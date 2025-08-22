import 'package:flutter/foundation.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/create_routine/create_routine_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/create_routine/create_routine_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_all_user_routines/get_all_user_routines_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_all_user_routines/get_all_user_routines_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_by_id/get_routine_by_id_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_by_id/get_routine_by_id_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_stats/get_routine_stats_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_stats/get_routine_stats_response.dart';
import 'package:routines_gym_app/infraestructure/datasource/routine_datasource.dart';
import 'package:routines_gym_app/transversal/common/response_codes.dart';

class RoutineRepository {
  final RoutineDatasource routineDatasource = RoutineDatasource();

  Future<GetRoutineStatsResponse> getRoutineStats(GetRoutineStatsRequest getRoutineStatsRequest) async 
  {
     GetRoutineStatsResponse getRoutineStatsResponse = GetRoutineStatsResponse();
    try 
    {
      Map<String, dynamic> data = await routineDatasource.getRoutineStats(getRoutineStatsRequest);
      if (data['responseCodeJson'] == 200) {
        getRoutineStatsResponse.isSuccess = data['isSuccess'];
        getRoutineStatsResponse.message = data['message'];
        getRoutineStatsResponse.routinesCount = data['routinesCount'];
        getRoutineStatsResponse.exercisesCount = data['exercisesCount'];
        getRoutineStatsResponse.splitsCount = data['splitsCount'];
      } else {
        getRoutineStatsResponse.isSuccess = false;
        getRoutineStatsResponse.message = data['message'] ?? 'Error getting routine stats';
      }
      getRoutineStatsResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } 
    catch (e) {
      if (kDebugMode) {
        print("Error getting routine stats: $e");
      }
      getRoutineStatsResponse.isSuccess = false;
      getRoutineStatsResponse.message = "Failed to getting routine stats";
    }

    return getRoutineStatsResponse;
  }

  Future<CreateRoutineResponse> createRoutine(CreateRoutineRequest createRoutineRequest) async 
  {
    CreateRoutineResponse createRoutineResponse = CreateRoutineResponse();
    try 
    {
      Map<String, dynamic> data = await routineDatasource.createRoutine(createRoutineRequest);
      if (data['responseCodeJson'] == 200) {
        createRoutineResponse.isSuccess = data['isSuccess'];
        createRoutineResponse.message = data['message'];
      } else {
        createRoutineResponse.isSuccess = false;
        createRoutineResponse.message = data['message'] ?? 'Error creating routine';
      }
      createRoutineResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } 
    catch (e) {
      if (kDebugMode) {
        print("Error adding new friend: $e");
      }
      createRoutineResponse.isSuccess = false;
      createRoutineResponse.message = "Failed to add new friend";
    }

    return createRoutineResponse;
  }

  Future<GetAllUserRoutinesResponse> getAllUserRoutines(GetAllUserRoutinesRequest getAllUserRoutinesRequest) async 
  {
    GetAllUserRoutinesResponse getAllUserRoutinesResponse = GetAllUserRoutinesResponse();
    try 
    {
      Map<String, dynamic> data = await routineDatasource.getAllUserRoutines(getAllUserRoutinesRequest);
      if (data['responseCodeJson'] == 200) {
        getAllUserRoutinesResponse.isSuccess = data['isSuccess'];
        getAllUserRoutinesResponse.message = data['message'];
        data['routines'] != null 
          ? getAllUserRoutinesResponse.routines = 
            (data['routines'] as List)
                .map((item) => RoutineDTO.fromJson(item))
                .toList()
          : getAllUserRoutinesResponse.routines = []; 
      } else {
        getAllUserRoutinesResponse.isSuccess = false;
        getAllUserRoutinesResponse.message = data['message'] ?? 'Error getting user routines';
      }
      getAllUserRoutinesResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } 
    catch (e) {
      if (kDebugMode) {
        print("Error getting user routines: $e");
      }
      getAllUserRoutinesResponse.isSuccess = false;
      getAllUserRoutinesResponse.message = "Failed to getting user routines";
    }

    return getAllUserRoutinesResponse;
  }

  Future<GetRoutineByRoutineNameResponse> getRoutineByRoutineName(GetRoutineByRoutineNameRequest getRoutineByRoutineNameRequest) async 
  {
    GetRoutineByRoutineNameResponse getRoutineByRoutineNameResponse = GetRoutineByRoutineNameResponse();
    try 
    {
      Map<String, dynamic> data = await routineDatasource.getRoutineByRoutineName(getRoutineByRoutineNameRequest);
      if (data['responseCodeJson'] == 200) {
        getRoutineByRoutineNameResponse.isSuccess = data['isSuccess'];
        getRoutineByRoutineNameResponse.message = data['message'];
        getRoutineByRoutineNameResponse.routineDTO = RoutineDTO.fromJson(data['routineDTO']);
      } else {
        getRoutineByRoutineNameResponse.isSuccess = false;
        getRoutineByRoutineNameResponse.message = data['message'] ?? 'Error getting user routines';
      }
      getRoutineByRoutineNameResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } 
    catch (e) {
      if (kDebugMode) {
        print("Error getting user routines: $e");
      }
      getRoutineByRoutineNameResponse.isSuccess = false;
      getRoutineByRoutineNameResponse.message = "Failed to getting user routines";
    }

    return getRoutineByRoutineNameResponse;
  }
}