// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/add_exercise_progress/add_exercise_progress_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/update_exercise/update_exercise_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/delete_exercise/delete_exercise_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/add_exercise/add_exercise_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/get_exercises_by_day_and_routine_id/get_exercises_by_day_and_routine_id_request.dart';
import 'package:routines_gym_app/configuration/constants/app_constants.dart';

class ExerciseDatasource {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> addExerciseProgress(AddExerciseProgressRequest request) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.exerciseEndpoint}/add-exercise-progress',
        data: {
          'progressList': request.progressList,
          'userEmail': request.userEmail,
          'routineId': request.routineId,
          'dayName': request.dayName,
        },
      );
      
      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }
    
    return data;
  }

  Future<Map<String, dynamic>> updateExercise(UpdateExerciseRequest request) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.exerciseEndpoint}/update-exercise',
        data: {
          'userId': request.userId,
          'routineId': request.routineId,
          'dayName': request.dayName,
          'exerciseName': request.exerciseName,
          'sets': request.sets,
          'reps': request.reps,
          'weight': request.weight,
        },
      );
      
      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }
    
    return data;
  }

  Future<Map<String, dynamic>> deleteExercise(DeleteExerciseRequest request) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.exerciseEndpoint}/delete-exercise',
        data: {
          'userEmail': request.userEmail,
          'routineId': request.routineId,
          'dayName': request.dayName,
          'exerciseId': request.exerciseId,
        },
      );
      
      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }
    
    return data;
  }

  Future<Map<String, dynamic>> addExercise(AddExerciseRequest request) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.exerciseEndpoint}/add-exercise',
        data: {
          'routineId': request.routineId,
          'exerciseName': request.exerciseName,
          'dayName': request.dayName,
          'userEmail': request.userEmail,
        },
      );
      
      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }
    
    return data;
  }

  Future<Map<String, dynamic>> getExercisesByDayAndRoutineId(GetExercisesByDayAndRoutineIdRequest request) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.exerciseEndpoint}/get-exercises-by-day-and-routine-id',
        data: {
          'routineId': request.routineId,
          'dayName': request.dayName,
        },
      );
      
      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }
    
    return data;
  }
}