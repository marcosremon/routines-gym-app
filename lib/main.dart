import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/stats/set_daily_steps/set_daily_steps_request.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/controller/routine/routine_controller.dart';
import 'package:routines_gym_app/presentation/controller/stats/steps_tracker.dart';
import 'package:routines_gym_app/presentation/screens/home/home_screen.dart';
import 'package:routines_gym_app/presentation/screens/welcome/welcome_screen.dart';
import 'package:routines_gym_app/provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await requestPermissions(); 
  runApp(const MyApp());
  scheduleDailyReset();
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final AuthProvider auth = AuthProvider();
            auth.init(); 
            return auth;
          },
        ),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => StatsProvider()),
        ChangeNotifierProvider(create: (_) => FriendProvider()),
        ChangeNotifierProvider(create: (_) => RoutineProvider()),
        ChangeNotifierProvider(create: (_) => RoutineController()), 
        ChangeNotifierProvider(create: (_) => StepTracker()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return MaterialApp(
            title: 'Routines Gym App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme(selectedColor: 7).theme(),
            home: authProvider.isLoggedIn
              ? const HomeScreen()
              : const WelcomeScreen(),
          );
        },
      ),
    );
  }
}


Future<void> requestPermissions() async {
  var status = await Permission.activityRecognition.status;
  if (!status.isGranted) {
    await Permission.activityRecognition.request();
  }
}

void scheduleDailyReset() async {
  final now = DateTime.now();
  final nextMidnight = DateTime(now.year, now.month, now.day + 1);
  final durationUntilMidnight = nextMidnight.difference(now);

  await AndroidAlarmManager.oneShot(
    durationUntilMidnight,
    0,
    dailyResetCallback,
    exact: true,
    wakeup: true,
    rescheduleOnReboot: true,
  );
}

@pragma('vm:entry-point') 
Future<void> dailyResetCallback() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final stepsToday = prefs.getInt('stepsToday') ?? 0;

  final statsProvider = StatsProvider();
  final request = SetDailyStepsRequest(
    steps: stepsToday,
    limitStepsPerDay: prefs.getInt('dailyGoal') ?? 10000,
    date: DateTime.now().subtract(const Duration(days: 1)),
  );

  final response = await statsProvider.setDailySteps(request);
  
  debugPrint("Daily reset: ${response.message}");

  prefs.setInt('stepsToday', 0);
  prefs.setString('lastResetDate', DateTime.now().toIso8601String());

  scheduleDailyReset();
}