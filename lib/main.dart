import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/controller/routine/routine_controller.dart';
import 'package:routines_gym_app/presentation/controller/stats/steps_tracker.dart';
import 'package:routines_gym_app/presentation/screens/home/home_screen.dart';
import 'package:routines_gym_app/presentation/screens/welcome/welcome_screen.dart';
import 'package:routines_gym_app/provider/exercise/exercise_provider.dart';
import 'package:routines_gym_app/provider/provider.dart';
import 'package:routines_gym_app/provider/split_day/split_day_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestPermissions();
  runApp(const MyApp());
}

Future<void> requestPermissions() async {
  var status = await Permission.activityRecognition.status;
  if (!status.isGranted) {
    await Permission.activityRecognition.request();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          final auth = AuthProvider();
          auth.init();
          return auth;
        }),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => StatsProvider()),
        ChangeNotifierProvider(create: (_) => FriendProvider()),
        ChangeNotifierProvider(create: (_) => RoutineProvider()),
        ChangeNotifierProvider(create: (_) => ExerciseProvider()),
        ChangeNotifierProvider(create: (_) => SplitDayProvider()),
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
