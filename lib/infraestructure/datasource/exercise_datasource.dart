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

  Future<Map<String, dynamic>> addExerciseProgress(AddExerciseProgressRequest addExerciseProgressRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.exerciseEndpoint}/add-exercise-progress',
        data: {
          'progressList': addExerciseProgressRequest.progressList,
          'userEmail': addExerciseProgressRequest.userEmail,
          'routineId': addExerciseProgressRequest.routineId,
          'splitDayId': addExerciseProgressRequest.splitDayId,
          'exerciseName': addExerciseProgressRequest.exerciseName
        },
      );

      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }
    
    return data;
  }

  Future<Map<String, dynamic>> updateExercise(UpdateExerciseRequest updateExerciseRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.exerciseEndpoint}/update-exercise',
        data: {
          'userId': updateExerciseRequest.userId,
          'routineId': updateExerciseRequest.routineId,
          'dayName': updateExerciseRequest.dayName,
          'exerciseName': updateExerciseRequest.exerciseName,
          'sets': updateExerciseRequest.sets,
          'reps': updateExerciseRequest.reps,
          'weight': updateExerciseRequest.weight,
        },
      );
      
      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }
    
    return data;
  }

  Future<Map<String, dynamic>> deleteExercise(DeleteExerciseRequest deleteExerciseRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.exerciseEndpoint}/delete-exercise',
        data: {
          'userEmail': deleteExerciseRequest.userEmail,
          'routineId': deleteExerciseRequest.routineId,
          'dayName': deleteExerciseRequest.dayName,
          'exerciseName': deleteExerciseRequest.exerciseName,
        },
      );
      
      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }
    
    return data;
  }

  Future<Map<String, dynamic>> addExercise(AddExerciseRequest addExerciseRequest) async {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.exerciseEndpoint}/add-exercise',
        data: {
          'routineName': addExerciseRequest.routineName,
          'exerciseName': addExerciseRequest.exerciseName,
          'dayName': addExerciseRequest.dayName,
          'userEmail': addExerciseRequest.userEmail,
        },
      );
      
      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }
    
    return data;
  }

  Future<Map<String, dynamic>> getExercisesByDayAndRoutineName(GetExercisesByDayAndRoutineNameRequest getExercisesByDayAndRoutineNameRequest) async 
  {
    Map<String, dynamic> data = {};
    try {
      dynamic response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.exerciseEndpoint}/get-exercises-by-day-and-routine-name',
        data: {
          'routineName': getExercisesByDayAndRoutineNameRequest.routineName,
          'dayName': getExercisesByDayAndRoutineNameRequest.dayName,
          'userEmail': getExercisesByDayAndRoutineNameRequest.userEmail
        },
      );
      
      data = response.data as Map<String, dynamic>;
    } catch (ex) {
      print("unexpected error");
    }
    
    return data;
  }
}