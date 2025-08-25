import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pedometer/pedometer.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/stats/get_stats/get_stats_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/stats/set_daily_steps/set_daily_steps_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/stats/set_daily_steps/set_daily_steps_response.dart';
import 'package:routines_gym_app/domain/model/entities/stat.dart';
import 'package:routines_gym_app/provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepTracker extends ChangeNotifier {
  int _stepsToday = 0;
  int _initialSteps = 0;
  int _dailyGoal = 10000;
  Timer? _saveTimer;

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
    _initialSteps = prefs.getInt('initialSteps') ?? 0;
    _stepsToday = prefs.getInt('stepsToday') ?? 0;

    await _checkResetNeeded();
    await updateFromApiResponse();

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(_onStepCount).onError(_onStepCountError);

    _startPeriodicSave();
  }

  void _startPeriodicSave() {
    _saveTimer?.cancel();
    _saveTimer = Timer.periodic(const Duration(minutes: 1), (_) async {
      debugPrint("⏱ Guardando pasos automáticamente...");
      await saveStepsWithoutResetting();
    });
  }

  Future<void> _checkResetNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final lastReset = prefs.getString('lastResetDate');
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (lastReset == null || DateTime.parse(lastReset).isBefore(today)) {
      await saveAndResetSteps();
      await prefs.setString('lastResetDate', today.toIso8601String());
    } else {
      _stepsToday = prefs.getInt('stepsToday') ?? 0;
    }
  }

  void _onStepCount(StepCount event) async {
    final prefs = await SharedPreferences.getInstance();

    if (_initialSteps == 0) {
      _initialSteps = event.steps;
      await prefs.setInt('initialSteps', _initialSteps);
    }

    _stepsToday = event.steps - _initialSteps;
    await prefs.setInt('stepsToday', _stepsToday);
    notifyListeners();
  }

  void _onStepCountError(error) {
    if (kDebugMode) {
      print('Step Count Error: $error');
    }
  }

  Future<void> updateFromApiResponse() async {
    final StatsProvider statsProvider = StatsProvider();
    GetStatsResponse getStatsResponse = await statsProvider.getStats();
    if (getStatsResponse.isSuccess!) {
      completeDays = getStatsResponse.stats ?? [];
      notifyListeners();
    }
  }

  void setDailyGoal(int goal) async {
    _dailyGoal = goal;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('dailyGoal', goal);
    notifyListeners();
  }

  Future<void> saveAndResetSteps() async {
    final prefs = await SharedPreferences.getInstance();
    final statsProvider = StatsProvider();

    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final yesterdayDate = DateTime(yesterday.year, yesterday.month, yesterday.day);

    final SaveDailyStepsRequest request = SaveDailyStepsRequest(
      steps: _stepsToday,
    );

    final SaveDailyStepsResponse response = await statsProvider.saveDailySteps(request);

    if (response.isSuccess ?? false) {
      final existingIndex = completeDays.indexWhere((stat) => isSameDay(stat.date, yesterdayDate));
      if (existingIndex != -1) {
        completeDays[existingIndex] = Stats(date: yesterdayDate, steps: _stepsToday);
      } else {
        completeDays.add(Stats(date: yesterdayDate, steps: _stepsToday));
      }

      completeDays.sort((a, b) => b.date.compareTo(a.date));

      _initialSteps = 0;
      _stepsToday = 0;
      await prefs.setInt('stepsToday', 0);
      await prefs.setInt('initialSteps', 0);

      notifyListeners();

      // 🔄 Recargar desde la base de datos
      await updateFromApiResponse();
    } else {
      if (kDebugMode) {
        print("Error guardando pasos: ${response.message}");
      }
    }
  }

  Future<void> saveStepsWithoutResetting() async {
    final statsProvider = StatsProvider();
    final now = DateTime.now();

    final SaveDailyStepsRequest request = SaveDailyStepsRequest(
      steps: _stepsToday,
    );

    final SaveDailyStepsResponse response = await statsProvider.saveDailySteps(request);

    if (response.isSuccess ?? false) {
      final existingIndex = completeDays.indexWhere((stat) => isSameDay(stat.date, now));
      if (existingIndex != -1) {
        completeDays[existingIndex] = Stats(date: now, steps: _stepsToday);
      } else {
        completeDays.add(Stats(date: now, steps: _stepsToday));
      }

      completeDays.sort((a, b) => b.date.compareTo(a.date));
      notifyListeners();

      // 🔄 Recargar desde la base de datos
      await updateFromApiResponse();
    } else {
      if (kDebugMode) {
        print("Error guardando pasos: ${response.message}");
      }
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  @override
  void dispose() {
    _saveTimer?.cancel();
    super.dispose();
  }
}
