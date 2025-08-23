import 'package:flutter/foundation.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/exercise_dto.dart';
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
      if (kDebugMode) {
        print("Error getting exercises by day and routine: $e");
      }
      getExercisesByDayAndRoutineNameResponse.isSuccess = false;
      getExercisesByDayAndRoutineNameResponse.message =
          "Failed to get exercises by day and routine";
    }

    return getExercisesByDayAndRoutineNameResponse;
  }
}