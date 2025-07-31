import 'package:flutter/material.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/screens/welcome_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(
    //       create: (_) => ChatProvider(),
    //     ),
    //   ],
      return MaterialApp(
        title: 'Routines Gym App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme(selectedColor: 7).theme(),
        home: Scaffold(
          body: WelcomeScreen(),
        ),
      );
    // );
  }
}