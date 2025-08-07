import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/controller/routine_controller.dart';
import 'package:routines_gym_app/presentation/screens/home/home_screen.dart';
import 'package:routines_gym_app/presentation/screens/welcome/welcome_screen.dart';
import 'package:routines_gym_app/provider/friend/friend_provider.dart';
import 'package:routines_gym_app/provider/provider.dart';

void main() async {
  runApp(const MyApp());
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
        ChangeNotifierProvider(create: (_) => FriendProvider()),
        ChangeNotifierProvider(create: (_) => RoutineController()), 
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return MaterialApp(
            title: 'Routines Gym App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme(selectedColor: 7).theme(),
            home: authProvider.isLoggedIn
              ? const HomeScreen()
              : const HomeScreen(),
          );
        },
      ),
    );
  }
}