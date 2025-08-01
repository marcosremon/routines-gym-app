import 'package:dio/dio.dart';
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
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/update_routine/update_routine_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/update_routine/update_routine_response.dart';
import 'package:routines_gym_app/configuration/constants/app_constants.dart';
import 'package:routines_gym_app/transversal/common/response_codes.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class RoutineDatasource {

  final Dio dio = Dio();

  Future<CreateRoutineResponse> createRoutine(CreateRoutineRequest createRoutineRequest) async {
    CreateRoutineResponse createRoutineResponse = CreateRoutineResponse();
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.routineEndpoint}/create-routine',
        data: {
          'userEmail': createRoutineRequest.userEmail,
          'routineName': createRoutineRequest.routineName,
          'routineDescription': createRoutineRequest.routineDescription,
          'splitDays': createRoutineRequest.splitDays,
          'sets': createRoutineRequest.sets,
          'reps': createRoutineRequest.reps,
          'weight': createRoutineRequest.weight,
        },
      );

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCode'] == ResponseCodes.ok) {
        createRoutineResponse.isSuccess = data['isSuccess'];
        createRoutineResponse.message = data['message'];
        createRoutineResponse.routineDTO = data['routineDTO'];
      } else {
        createRoutineResponse.isSuccess = false;
        createRoutineResponse.message = 'Error: ${response.statusMessage}';
      }
    } catch (ex) {
      createRoutineResponse.isSuccess = false;
      createRoutineResponse.message = 'unexpected error on RoutineDatasource -> createRoutine: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return createRoutineResponse;
  }

  Future<UpdateRoutineResponse> updateRoutine(UpdateRoutineRequest updateRoutineRequest) async {
    UpdateRoutineResponse updateRoutineResponse = UpdateRoutineResponse();
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

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCode'] == ResponseCodes.ok) {
        updateRoutineResponse.isSuccess = data['isSuccess'];
        updateRoutineResponse.message = data['message'];
        updateRoutineResponse.routineDTO = data['routineDTO'];
      } else {
        updateRoutineResponse.isSuccess = false;
        updateRoutineResponse.message = 'Error: ${response.statusMessage}';
      }
    } catch (ex) {
      updateRoutineResponse.isSuccess = false;
      updateRoutineResponse.message = 'unexpected error on RoutineDatasource -> updateRoutine: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return updateRoutineResponse;
  }

  Future<DeleteRoutineResponse> deleteRoutine(DeleteRoutineRequest deleteRoutineRequest) async {
    DeleteRoutineResponse deleteRoutineResponse = DeleteRoutineResponse();
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.routineEndpoint}/delete-routine',
        data: {
          'userEmail': deleteRoutineRequest.userEmail,
          'routineId': deleteRoutineRequest.routineId,
        },
      );

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCode'] == ResponseCodes.ok) {
        deleteRoutineResponse.isSuccess = data['isSuccess'];
        deleteRoutineResponse.message = data['message'];
        deleteRoutineResponse.userId = data['userId'];
      } else {
        deleteRoutineResponse.isSuccess = false;
        deleteRoutineResponse.message = 'Error: ${response.statusMessage}';
      }
    } catch (ex) {
      deleteRoutineResponse.isSuccess = false;
      deleteRoutineResponse.message = 'unexpected error on RoutineDatasource -> deleteRoutine: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return deleteRoutineResponse;
  }

  Future<GetAllUserRoutinesResponse> getAllUserRoutines(GetAllUserRoutinesRequest getAllUserRoutinesRequest) async {
    GetAllUserRoutinesResponse getAllUserRoutinesResponse = GetAllUserRoutinesResponse();
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.routineEndpoint}/get-all-user-routines',
        data: {
          'userEmail': getAllUserRoutinesRequest.userEmail,
        },
      );

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCode'] == ResponseCodes.ok) {
        getAllUserRoutinesResponse.isSuccess = data['isSuccess'];
        getAllUserRoutinesResponse.message = data['message'];
        getAllUserRoutinesResponse.routines = data['routines'];
      } else {
        getAllUserRoutinesResponse.isSuccess = false;
        getAllUserRoutinesResponse.message = 'Error: ${response.statusMessage}';
      }
    } catch (ex) {
      getAllUserRoutinesResponse.isSuccess = false;
      getAllUserRoutinesResponse.message = 'unexpected error on RoutineDatasource -> getAllUserRoutines: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return getAllUserRoutinesResponse;
  }

  Future<GetRoutineStatsResponse> getRoutineStats(GetRoutineStatsRequest getRoutineStatsRequest) async {
    GetRoutineStatsResponse getRoutineStatsResponse = GetRoutineStatsResponse();
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.routineEndpoint}/get-routine-stats',
        data: {
          'userEmail': getRoutineStatsRequest.userEmail,
        },
      );

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCode'] == ResponseCodes.ok) {
        getRoutineStatsResponse.isSuccess = data['isSuccess'];
        getRoutineStatsResponse.message = data['message'];
        getRoutineStatsResponse.routinesCount = data['routinesCount'];
        getRoutineStatsResponse.exercisesCount = data['exercisesCount'];
        getRoutineStatsResponse.splitsCount = data['splitsCount'];
      } else {
        getRoutineStatsResponse.isSuccess = false;
        getRoutineStatsResponse.message = 'Error: ${response.statusMessage}';
      }
    } catch (ex) {
      getRoutineStatsResponse.isSuccess = false;
      getRoutineStatsResponse.message = 'unexpected error on RoutineDatasource -> getRoutineStats: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return getRoutineStatsResponse;
  }

  Future<GetRoutineByIdResponse> getRoutineById(GetRoutineByIdRequest getRoutineByIdRequest) async {
    GetRoutineByIdResponse getRoutineByIdResponse = GetRoutineByIdResponse();
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.routineEndpoint}/get-routine-by-id',
        data: {
          'routineId': getRoutineByIdRequest.routineId,
        },
      );

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data['responseCode'] == ResponseCodes.ok) {
        getRoutineByIdResponse.isSuccess = data['isSuccess'];
        getRoutineByIdResponse.message = data['message'];
        getRoutineByIdResponse.routineDTO = data['routineDTO'];
      } else {
        getRoutineByIdResponse.isSuccess = false;
        getRoutineByIdResponse.message = 'Error: ${response.statusMessage}';
      }
    } catch (ex) {
      getRoutineByIdResponse.isSuccess = false;
      getRoutineByIdResponse.message = 'unexpected error on RoutineDatasource -> getRoutineById: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }

    return getRoutineByIdResponse;
  }
}