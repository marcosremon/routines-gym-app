// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/screens/home/profile/profile_screen.dart';
import 'package:routines_gym_app/presentation/screens/home/social/social_screen.dart';
import 'package:routines_gym_app/presentation/screens/home/stats/stats_screen.dart';
import 'package:routines_gym_app/presentation/screens/home/training/training_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  Widget _getCurrentScreen() {
    switch (_selectedIndex) {
      case 0:
        return const StatsScreen();
      case 1:
        return TrainingScreen();
      case 2:
        return const SocialScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const StatsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentScreen(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: colorThemes[9], // white color
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, -2), 
            ),
          ],
        ),
        child: _navBar(),
      ),
    );
  }

  BottomNavigationBar _navBar() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        unselectedItemColor: Colors.grey[400],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/stats_icon.png'),
              size: 28,
            ),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/training_icon.png'),
              size: 28,
            ),
            label: 'Training',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/social_icon.png'),
              size: 28,
            ),
            label: 'Social',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/profile_icon.png'),
              size: 28,
            ),
            label: 'Profile',
          ),
        ]
      );
  }
}