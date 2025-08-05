// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/create_routine/create_routine_request.dart';
import 'package:routines_gym_app/provider/routine/routine_provider.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';
import 'package:shared_preferences/shared_preferences.dart';import 'package:provider/provider.dart';

class RoutineController extends ChangeNotifier {
  final nameController = TextEditingController();
  final descController = TextEditingController();

  final List<int> selectedDays = [];
  final Map<int, List<Map<String, TextEditingController>>> exercisesByDay = {};

  final List<String> weekDays = [
    'Monday', 'Thuesday', 'Wednes', 'Thursday', 'Friday', 'Saturday', 'Sunday'
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
        ToastMessage.showToast('Rellena todos los campos');
      }
      return;
    }
    if (selectedDays.isEmpty) {
      if (context.mounted) {
        ToastMessage.showToast('Selecciona al menos un día');
      }
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');

    if (email == null) {
      if (context.mounted) {
        ToastMessage.showToast('No se encontró el email del usuario');
      }
      return;
    }

    Map<String, dynamic> routine = {
      "userEmail": email,
      "routineName": name,
      "routineDescription": desc,
      "splitDays": selectedDays.map((day) {
        return {
          "dayName": day,
          "exercises": exercisesByDay[day]!.map((exerciseCtrls) {
            return {
              "exerciseId": 0,
              "exerciseName": exerciseCtrls["exerciseName"]!.text.trim(),
              "sets": int.tryParse(exerciseCtrls["sets"]!.text) ?? 0,
              "reps": int.tryParse(exerciseCtrls["reps"]!.text) ?? 0,
              "weight": double.tryParse(exerciseCtrls["weight"]!.text) ?? 0,
              "dayName": day + 1
            };
          }).toList()
        };
      }).toList()
    };

    CreateRoutineRequest createRoutineRequest = CreateRoutineRequest(
      userEmail: email,
      routineName: name,
      routineDescription: desc,
      splitDays: routine["splitDays"],
    );

    await context.read<RoutineProvider>().createRoutine(createRoutineRequest);
    clear();

    if (context.mounted) Navigator.of(context).pop();
  }

  void toggleDay(int day) {
  if (selectedDays.contains(day)) {
    removeDay(day);
  } else {
    addDay(day);
  }
}
}