import 'package:routines_gym_app/application/data_transfer_object/entities/exercise_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/add_exercise/add_exercise_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/add_exercise/add_exercise_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/add_exercise_progress/add_exercise_progress_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/add_exercise_progress/add_exercise_progress_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/delete_exercise/delete_exercise_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/delete_exercise/delete_exercise_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/get_exercises_by_day_and_routine_id/get_exercises_by_day_and_routine_id_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/get_exercises_by_day_and_routine_id/get_exercises_by_day_and_routine_id_response.dart';
import 'package:routines_gym_app/infraestructure/datasource/exercise_datasource.dart';
import 'package:routines_gym_app/transversal/common/response_codes.dart';

class ExerciseRepository {
  final ExerciseDatasource exerciseDatasource = ExerciseDatasource();

  Future<GetExercisesByDayAndRoutineNameResponse> getExercisesByDayAndRoutineName(GetExercisesByDayAndRoutineNameRequest getExercisesByDayAndRoutineNameRequest) async 
  {
    GetExercisesByDayAndRoutineNameResponse getExercisesByDayAndRoutineNameResponse = GetExercisesByDayAndRoutineNameResponse();
    try {
      Map<String, dynamic> data = await exerciseDatasource.getExercisesByDayAndRoutineName(getExercisesByDayAndRoutineNameRequest);

      if (data['responseCodeJson'] == 200) {
        getExercisesByDayAndRoutineNameResponse.isSuccess = data['isSuccess'];
        getExercisesByDayAndRoutineNameResponse.message = data['message'];
        getExercisesByDayAndRoutineNameResponse.exercises = data['exercises'] != null
            ? (data['exercises'] as List).map((item) => ExerciseDTO.fromJson(item)).toList()
            : [];
        getExercisesByDayAndRoutineNameResponse.pastProgress = data['pastProgress'] != null
            ? (data['pastProgress'] as Map<String, dynamic>).map(
                (key, value) => MapEntry(
                  int.parse(key),
                  (value as List).map((e) => e.toString()).toList()),
                )
            : {};
      } else {
        getExercisesByDayAndRoutineNameResponse.isSuccess = false;
        getExercisesByDayAndRoutineNameResponse.message = data['message'] 
          ?? 'Error getting exercises by day and routine';
      }
      getExercisesByDayAndRoutineNameResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } catch (e) {
      getExercisesByDayAndRoutineNameResponse.isSuccess = false;
      getExercisesByDayAndRoutineNameResponse.message = 'Unexpected error on ExerciserRepository -> getExercisesByDayAndRoutineName';
    }

    return getExercisesByDayAndRoutineNameResponse;
  }

  Future<AddExerciseProgressResponse> addExerciseProgress(AddExerciseProgressRequest addExerciseProgressRequest) async 
  {
    AddExerciseProgressResponse addExerciseProgressResponse = AddExerciseProgressResponse();
    try {
      Map<String, dynamic> data = await exerciseDatasource.addExerciseProgress(addExerciseProgressRequest);
      if (data['responseCodeJson'] == 200) {
        addExerciseProgressResponse.isSuccess = data['isSuccess'];
        addExerciseProgressResponse.message = data['message'];
      } else {
        addExerciseProgressResponse.isSuccess = false;
        addExerciseProgressResponse.message = 'Error: ${data['message']}';
      }
      addExerciseProgressResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } catch (ex) {
      addExerciseProgressResponse.isSuccess = false;
      addExerciseProgressResponse.message = 'Unexpected error on ExerciserRepository -> addExerciseProgress';
    }
    
    return addExerciseProgressResponse;
  }

  Future<AddExerciseResponse> addExercise(AddExerciseRequest addExerciseRequest) async 
  {
    AddExerciseResponse addExerciseResponse = AddExerciseResponse();
    try {
      Map<String, dynamic> data = await exerciseDatasource.addExercise(addExerciseRequest);
      if (data['responseCodeJson'] == 200) {
        addExerciseResponse.isSuccess = data['isSuccess'];
        addExerciseResponse.message = data['message'];
      } else {
        addExerciseResponse.isSuccess = false;
        addExerciseResponse.message = 'Error: ${data['message']}';
      }
      addExerciseResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } catch (ex) {
      addExerciseResponse.isSuccess = false;
      addExerciseResponse.message = 'Unexpected error on ExerciseRepository -> addExercise';
    }
    
    return addExerciseResponse;
  }

  Future<DeleteExerciseResponse> deleteExercise(DeleteExerciseRequest deleteExerciseRequest) async 
  {
    DeleteExerciseResponse deleteExerciseResponse = DeleteExerciseResponse();
    try {
      Map<String, dynamic> data = await exerciseDatasource.deleteExercise(deleteExerciseRequest);
      if (data['responseCodeJson'] == 200) {
        deleteExerciseResponse.isSuccess = data['isSuccess'];
        deleteExerciseResponse.message = data['message'];
      } else {
        deleteExerciseResponse.isSuccess = false;
        deleteExerciseResponse.message = 'Error: ${data['message']}';
      }
      deleteExerciseResponse.responseCode = ResponseCodes.fromValue(data['responseCodeJson']);
    } catch (ex) {
      deleteExerciseResponse.isSuccess = false;
      deleteExerciseResponse.message = 'Unexpected error on ExerciseRepository -> deleteExercise';
    }
    
    return deleteExerciseResponse;
  }
}