// ignore_for_file: strict_top_level_inference

import 'package:flutter/foundation.dart';
import 'package:pedometer/pedometer.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/stats/get_stats/get_stats_response.dart';
import 'package:routines_gym_app/domain/model/entities/stat.dart';
import 'package:routines_gym_app/provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepTracker extends ChangeNotifier {
  int _stepsToday = 0;
  int _initialSteps = 0;
  int _dailyGoal = 10000;

  int get stepsToday => _stepsToday;
  int get dailyGoal => _dailyGoal;

  List<Stats> completeDays = [];

  late Stream<StepCount> _stepCountStream;

  StepTracker() {
    _initialize();
  }

  Future<void> _initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _dailyGoal = prefs.getInt('dailyGoal') ?? 10000;

    await _checkResetNeeded();
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(_onStepCount).onError(_onStepCountError);
  }

  Future<void> _checkResetNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final lastReset = prefs.getString('lastResetDate');
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (lastReset == null || DateTime.parse(lastReset).isBefore(today)) {
      if (_stepsToday > 0) {
        completeDays.add(Stats(date: today.subtract(const Duration(days: 1)), steps: _stepsToday));
      }
      _resetSteps();
      await prefs.setString('lastResetDate', today.toIso8601String());
    } else {
      _stepsToday = prefs.getInt('stepsToday') ?? 0;
    }
  }

  void _onStepCount(StepCount event) {
    if (_initialSteps == 0) {
      _initialSteps = event.steps;
    }
    _stepsToday = event.steps - _initialSteps;
    notifyListeners();
  }

  void _onStepCountError(error) {
    if (kDebugMode) {
      print('Step Count Error: $error');
    }
  }

  Future<void> _resetSteps() async {
    _initialSteps = 0;
    _stepsToday = 0;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('stepsToday', 0);
    notifyListeners();
  }

  void setDailyGoal(int goal) {
    _dailyGoal = goal;
    notifyListeners();
  }

  Future<void> updateFromApiResponse() async {
    final StatsProvider statsProvider = StatsProvider();
    GetStatsResponse getStatsResponse = await statsProvider.getStats();
    if (getStatsResponse.isSuccess!) {
      completeDays = getStatsResponse.stats ?? [];
      notifyListeners();
    } else {
      if (kDebugMode) {
        print("Error al cargar datos: ${getStatsResponse.message}");
      }
    }
  }
}
