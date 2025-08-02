import 'package:dio/dio.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/create_routine/create_routine_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/delete_routine/delete_routine_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_all_user_routines/get_all_user_routines_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_by_id/get_routine_by_id_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_stats/get_routine_stats_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/update_routine/update_routine_request.dart';
import 'package:routines_gym_app/configuration/constants/app_constants.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class RoutineDatasource {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> createRoutine(CreateRoutineRequest request) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.routineEndpoint}/create-routine',
        data: {
          'userEmail': request.userEmail,
          'routineName': request.routineName,
          'routineDescription': request.routineDescription,
          'splitDays': request.splitDays,
          'sets': request.sets,
          'reps': request.reps,
          'weight': request.weight,
        },
      );
      return response.data as Map<String, dynamic>;
    } catch (ex) {
      ToastMessage.showToast("unexpected error");
      return {
        'isSuccess': false,
        'message': 'unexpected error on RoutineDatasource -> createRoutine: ${ex.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> updateRoutine(UpdateRoutineRequest request) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.routineEndpoint}/update-routine',
        data: {
          'routineId': request.routineId,
          'routineName': request.routineName,
          'routineDescription': request.routineDescription,
          'splitDays': request.splitDays,
        },
      );
      return response.data as Map<String, dynamic>;
    } catch (ex) {
      ToastMessage.showToast("unexpected error");
      return {
        'isSuccess': false,
        'message': 'unexpected error on RoutineDatasource -> updateRoutine: ${ex.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> deleteRoutine(DeleteRoutineRequest request) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.routineEndpoint}/delete-routine',
        data: {
          'userEmail': request.userEmail,
          'routineId': request.routineId,
        },
      );
      return response.data as Map<String, dynamic>;
    } catch (ex) {
      ToastMessage.showToast("unexpected error");
      return {
        'isSuccess': false,
        'message': 'unexpected error on RoutineDatasource -> deleteRoutine: ${ex.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> getAllUserRoutines(GetAllUserRoutinesRequest request) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.routineEndpoint}/get-all-user-routines',
        data: {
          'userEmail': request.userEmail,
        },
      );
      return response.data as Map<String, dynamic>;
    } catch (ex) {
      ToastMessage.showToast("unexpected error");
      return {
        'isSuccess': false,
        'message': 'unexpected error on RoutineDatasource -> getAllUserRoutines: ${ex.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> getRoutineStats(GetRoutineStatsRequest request) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.routineEndpoint}/get-routine-stats',
        data: {
          'userEmail': request.userEmail,
        },
      );
      return response.data as Map<String, dynamic>;
    } catch (ex) {
      ToastMessage.showToast("unexpected error");
      return {
        'isSuccess': false,
        'message': 'unexpected error on RoutineDatasource -> getRoutineStats: ${ex.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> getRoutineById(GetRoutineByIdRequest request) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.routineEndpoint}/get-routine-by-id',
        data: {
          'routineId': request.routineId,
        },
      );
      return response.data as Map<String, dynamic>;
    } catch (ex) {
      ToastMessage.showToast("unexpected error");
      return {
        'isSuccess': false,
        'message': 'unexpected error on RoutineDatasource -> getRoutineById: ${ex.toString()}',
      };
    }
  }
}