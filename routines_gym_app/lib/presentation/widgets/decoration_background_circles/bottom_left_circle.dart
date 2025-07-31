import 'package:flutter/material.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';

class BottomLeftCircle extends StatelessWidget {
  const BottomLeftCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -55,
      left: -55,
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [colorThemes[6], colorThemes[7]], // gradiant desde el color 6 al color 7
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}