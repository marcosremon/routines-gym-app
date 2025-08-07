// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/create_routine/create_routine_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/delete_routine/delete_routine_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_all_user_routines/get_all_user_routines_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_by_id/get_routine_by_id_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_stats/get_routine_stats_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/update_routine/update_routine_request.dart';
import 'package:routines_gym_app/configuration/constants/app_constants.dart';

class RoutineDatasource {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> createRoutine(CreateRoutineRequest createRoutineRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.routineEndpoint}/create-routine',
        data: {
          'userEmail': createRoutineRequest.userEmail,
          'routineName': createRoutineRequest.routineName,
          'routineDescription': createRoutineRequest.routineDescription,
          'splitDays': createRoutineRequest.splitDays,
        },
      );
      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }

    return data;
  }

  Future<Map<String, dynamic>> updateRoutine(UpdateRoutineRequest updateRoutineRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.routineEndpoint}/update-routine',
        data: {
          'routineId': updateRoutineRequest.routineId,
          'routineName': updateRoutineRequest.routineName,
          'routineDescription': updateRoutineRequest.routineDescription,
          'splitDays': updateRoutineRequest.splitDays,
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }
    
    return data;
  }

  Future<Map<String, dynamic>> deleteRoutine(DeleteRoutineRequest deleteRoutineRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.routineEndpoint}/delete-routine',
        data: {
          'userEmail': deleteRoutineRequest.userEmail,
          'routineId': deleteRoutineRequest.routineId,
        },
      );
    
      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }
    
    return data;
  }

  Future<Map<String, dynamic>> getAllUserRoutines(GetAllUserRoutinesRequest getAllUserRoutinesRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.routineEndpoint}/get-all-user-routines',
        data: {
          'userEmail': getAllUserRoutinesRequest.userEmail,
        },
      );
      
      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }
    
    return data;
  }

  Future<Map<String, dynamic>> getRoutineStats(GetRoutineStatsRequest getRoutineStatsRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.routineEndpoint}/get-routine-stats',
        data: {
          'userEmail': getRoutineStatsRequest.userEmail,
        },
      );
      
      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }
    
    return data;
  }

  Future<Map<String, dynamic>> getRoutineById(GetRoutineByIdRequest getRoutineByIdRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.routineEndpoint}/get-routine-by-id',
        data: {
          'routineId': getRoutineByIdRequest.routineId,
        },
      );
      
      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }
    
    return data;
  }
}