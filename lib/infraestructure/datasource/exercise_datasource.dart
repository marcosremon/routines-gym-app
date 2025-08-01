import 'package:dio/dio.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/add_exercise/add_exercise_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/add_exercise/add_exercise_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/add_exercise_progress/add_exercise_progress_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/add_exercise_progress/add_exercise_progress_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/delete_exercise/delete_exercise_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/delete_exercise/delete_exercise_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/get_exercises_by_day_and_routine_id/get_exercises_by_day_and_routine_id_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/get_exercises_by_day_and_routine_id/get_exercises_by_day_and_routine_id_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/update_exercise/update_exercise_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/update_exercise/update_exercise_response.dart';
import 'package:routines_gym_app/configuration/constants/app_constants.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class ExerciseDatasource {
 
  final Dio dio = Dio();

  Future<AddExerciseProgressResponse> addExerciseProgress(AddExerciseProgressRequest request) async {
    AddExerciseProgressResponse response = AddExerciseProgressResponse();
    try {
      dynamic apiResponse = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.exerciseEndpoint}/add-exercise-progress',
        data: {
          'progressList': request.progressList,
          'userEmail': request.userEmail,
          'routineId': request.routineId,
          'dayName': request.dayName,
        },
      );

      Map<String, dynamic> data = apiResponse.data as Map<String, dynamic>;
      if (data['responseCodeJson'] == 200) {
        response.isSuccess = data['isSuccess'];
        response.message = data['message'];
        response.userDTO = data['userDTO'];
      } else {
        response.isSuccess = false;
        response.message = 'Error: ${apiResponse.statusMessage}';
      }
    } catch (ex) {
      response.isSuccess = false;
      response.message = 'unexpected error on ExerciseDatasource -> addExerciseProgress: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }
    return response;
  }

  Future<UpdateExerciseResponse> updateExercise(UpdateExerciseRequest request) async {
    UpdateExerciseResponse response = UpdateExerciseResponse();
    try {
      dynamic apiResponse = await dio.post(
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

      Map<String, dynamic> data = apiResponse.data as Map<String, dynamic>;
      if (data['responseCodeJson'] == 200) {
        response.isSuccess = data['isSuccess'];
        response.message = data['message'];
        response.userDTO = data['userDTO'];
      } else {
        response.isSuccess = false;
        response.message = 'Error: ${apiResponse.statusMessage}';
      }
    } catch (ex) {
      response.isSuccess = false;
      response.message = 'unexpected error on ExerciseDatasource -> updateExercise: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }
    return response;
  }

  Future<DeleteExerciseResponse> deleteExercise(DeleteExerciseRequest request) async {
    DeleteExerciseResponse response = DeleteExerciseResponse();
    try {
      dynamic apiResponse = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.exerciseEndpoint}/delete-exercise',
        data: {
          'userEmail': request.userEmail,
          'routineId': request.routineId,
          'dayName': request.dayName,
          'exerciseId': request.exerciseId,
        },
      );

      Map<String, dynamic> data = apiResponse.data as Map<String, dynamic>;
      if (data['responseCodeJson'] == 200) {
        response.isSuccess = data['isSuccess'];
        response.message = data['message'];
        response.userDTO = data['userDTO'];
      } else {
        response.isSuccess = false;
        response.message = 'Error: ${apiResponse.statusMessage}';
      }
    } catch (ex) {
      response.isSuccess = false;
      response.message = 'unexpected error on ExerciseDatasource -> deleteExercise: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }
    return response;
  }

  Future<AddExerciseResponse> addExercise(AddExerciseRequest request) async {
    AddExerciseResponse response = AddExerciseResponse();
    try {
      dynamic apiResponse = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.exerciseEndpoint}/add-exercise',
        data: {
          'routineId': request.routineId,
          'exerciseName': request.exerciseName,
          'dayName': request.dayName,
          'userEmail': request.userEmail,
        },
      );

      Map<String, dynamic> data = apiResponse.data as Map<String, dynamic>;
      if (data['responseCodeJson'] == 200) {
        response.isSuccess = data['isSuccess'];
        response.message = data['message'];
        response.userDTO = data['userDTO'];
      } else {
        response.isSuccess = false;
        response.message = 'Error: ${apiResponse.statusMessage}';
      }
    } catch (ex) {
      response.isSuccess = false;
      response.message = 'unexpected error on ExerciseDatasource -> addExercise: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }
    return response;
  }

  Future<GetExercisesByDayAndRoutineIdResponse> getExercisesByDayAndRoutineId(GetExercisesByDayAndRoutineIdRequest request) async {
    GetExercisesByDayAndRoutineIdResponse response = GetExercisesByDayAndRoutineIdResponse();
    try {
      dynamic apiResponse = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.exerciseEndpoint}/get-exercises-by-day-and-routine-id',
        data: {
          'routineId': request.routineId,
          'dayName': request.dayName,
        },
      );

      Map<String, dynamic> data = apiResponse.data as Map<String, dynamic>;
      if (data['responseCodeJson'] == 200) {
        response.isSuccess = data['isSuccess'];
        response.message = data['message'];
        response.exercises = data['exercises'];
        response.pastProgress = data['pastProgress'];
      } else {
        response.isSuccess = false;
        response.message = 'Error: ${apiResponse.statusMessage}';
      }
    } catch (ex) {
      response.isSuccess = false;
      response.message = 'unexpected error on ExerciseDatasource -> getExercisesByDayAndRoutineId: ${ex.toString()}';
      ToastMessage.showToast("unexpected error");
    }
    return response;
  }
}