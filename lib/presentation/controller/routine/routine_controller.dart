

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/exercise_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/split_day_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/create_routine/create_routine_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_by_id/get_routine_by_id_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_by_id/get_routine_by_id_response.dart';
import 'package:routines_gym_app/domain/model/enums/week_day.dart';
import 'package:routines_gym_app/provider/routine/routine_provider.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoutineController extends ChangeNotifier {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  GetRoutineByIdResponse? _selectedRoutineResponse;
  GetRoutineByIdResponse? get selectedRoutine => _selectedRoutineResponse;

  final List<int> selectedDays = [];
  final Map<int, List<Map<String, TextEditingController>>> exercisesByDay = {};

  final List<String> weekDays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];

  void addDay(int day) {
    if (!selectedDays.contains(day)) {
      selectedDays.add(day);
      exercisesByDay[day] = [
        {
          "exerciseName": TextEditingController(),
          "sets": TextEditingController(),
          "reps": TextEditingController(),
          "weight": TextEditingController(),
        }
      ];
      notifyListeners();
    }
  }

  void removeDay(int day) {
    selectedDays.remove(day);
    exercisesByDay.remove(day);
    notifyListeners();
  }

  void addExercise(int day) {
    exercisesByDay[day]?.add({
      "exerciseName": TextEditingController(),
      "sets": TextEditingController(),
      "reps": TextEditingController(),
      "weight": TextEditingController(),
    });
    notifyListeners();
  }

  void removeExercise(int day, int index) {
    exercisesByDay[day]?.removeAt(index);
    notifyListeners();
  }

  void clear() {
    nameController.clear();
    descController.clear();
    selectedDays.clear();
    for (var day in exercisesByDay.values) {
      for (var ctrls in day) {
        for (var c in ctrls.values) {
          c.dispose();
        }
      }
    }
    exercisesByDay.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    for (var day in exercisesByDay.values) {
      for (var ctrls in day) {
        for (var c in ctrls.values) {
          c.dispose();
        }
      }
    }
    super.dispose();
  }

  Future<void> submitRoutine(BuildContext context) async {
    final name = nameController.text.trim();
    final desc = descController.text.trim();

    if (name.isEmpty) {
      if (context.mounted) {
        ToastMessage.showToast('Please enter a routine name');
      }
      return;
    }

    if (selectedDays.isEmpty) {
      if (context.mounted) {
        ToastMessage.showToast('Select at least one day');
      }
      return;
    }

    // Validar que todos los ejercicios tengan nombre
    for (var day in selectedDays) {
      final exercises = exercisesByDay[day];
      if (exercises == null || exercises.isEmpty) {
        if (context.mounted) {
          ToastMessage.showToast('Add at least one exercise for ${weekDays[day]}');
        }
        return;
      }

      for (var ctrls in exercises) {
        final name = ctrls["exerciseName"]?.text.trim() ?? '';
        if (name.isEmpty) {
          if (context.mounted) {
            ToastMessage.showToast('Exercise name missing on ${weekDays[day]}');
          }
          return;
        }
      }
    }

    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('userEmail');

    if (email == null) {
      if (context.mounted) {
        ToastMessage.showToast('User email not found');
      }
      return;
    }

    final splitDaysList = selectedDays.map((dayIndex) {
      final dayName = WeekDay.values[dayIndex];
      final exercises = exercisesByDay[dayIndex]!.map((ctrls) {
        return ExerciseDTO(
          exerciseName: ctrls["exerciseName"]!.text.trim(),
          routineId: 0,
          splitDayId: 0,
        );
      }).toList();

      return SplitDayDTO(
        dayName: dayName,
        routineId: 0,
        dayExercisesDescription: "",
        exercises: exercises,
      );
    }).toList();

    final request = CreateRoutineRequest(
      userEmail: email,
      routineName: name,
      routineDescription: desc,
      splitDays: splitDaysList,
    );

    await context.read<RoutineProvider>().createRoutine(request);
    clear();

    if (context.mounted) {
      ToastMessage.showToast('Routine created successfully');
      Navigator.of(context).pop();
    }
  }

  void toggleDay(int day) {
    if (selectedDays.contains(day)) {
      removeDay(day);
    } else {
      addDay(day);
    }
  }
  
  Future<void> getRoutineById(int routineId, BuildContext context) async {
    final request = GetRoutineByIdRequest(routineId: routineId);
    final provider = context.read<RoutineProvider>();

    final response = await provider.getRoutineById(request);
    _selectedRoutineResponse = response;

    ToastMessage.showToast(response.message ?? 'Routine loaded');
    notifyListeners();
  }
}
