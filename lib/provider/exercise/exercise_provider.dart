import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/get_exercises_by_day_and_routine_id/get_exercises_by_day_and_routine_id_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/get_exercises_by_day_and_routine_id/get_exercises_by_day_and_routine_id_response.dart';
import 'package:routines_gym_app/infraestructure/repository/exercise_repository.dart';

class ExerciseProvider extends ChangeNotifier {
  final ExerciseRepository exerciseRepository = ExerciseRepository();

  GetExercisesByDayAndRoutineIdResponse? _exerciseProgressResponse;

  GetExercisesByDayAndRoutineIdResponse? get exerciseProgressResponse => _exerciseProgressResponse;

  Future<GetExercisesByDayAndRoutineIdResponse> getExercisesByDayAndRoutineId(
    GetExercisesByDayAndRoutineIdRequest request
  ) async {
    final response = await exerciseRepository.getExercisesByDayAndRoutineId(request);
    _exerciseProgressResponse = response;
    notifyListeners();
    return response;
  }

  void clearProgress() {
    _exerciseProgressResponse = null;
    notifyListeners();
  }
}