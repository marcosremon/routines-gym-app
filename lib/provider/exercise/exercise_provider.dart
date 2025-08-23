import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/add_exercise_progress/add_exercise_progress_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/add_exercise_progress/add_exercise_progress_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/get_exercises_by_day_and_routine_id/get_exercises_by_day_and_routine_id_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/get_exercises_by_day_and_routine_id/get_exercises_by_day_and_routine_id_response.dart';
import 'package:routines_gym_app/infraestructure/repository/exercise_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseProvider extends ChangeNotifier {
  final ExerciseRepository exerciseRepository = ExerciseRepository();

  GetExercisesByDayAndRoutineNameResponse? _exerciseProgressResponse;

  GetExercisesByDayAndRoutineNameResponse? get exerciseProgressResponse => _exerciseProgressResponse;

  Future<GetExercisesByDayAndRoutineNameResponse> getExercisesByDayAndRoutineName(GetExercisesByDayAndRoutineNameRequest getExercisesByDayAndRoutineNameRequest) async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getExercisesByDayAndRoutineNameRequest.userEmail ??= prefs.getString("userEmail");
    return await exerciseRepository.getExercisesByDayAndRoutineName(getExercisesByDayAndRoutineNameRequest);
  }

  void clearProgress() {
    _exerciseProgressResponse = null;
    notifyListeners();
  }

  Future<AddExerciseProgressResponse> addExerciseProgress(AddExerciseProgressRequest addExerciseProgressRequest) async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    addExerciseProgressRequest.userEmail ??= prefs.getString("userEmail");
    return await exerciseRepository.addExerciseProgress(addExerciseProgressRequest);
  }
}