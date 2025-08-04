import 'package:flutter/material.dart';

List<Color> colorThemes = [
  Colors.blue, // 0
  Colors.teal, // 1
  Colors.green, // 2
  Colors.yellow, // 3
  Colors.orange, // 4
  Colors.pink, // 5
  Color(0xFFFBC369), // 6
  Color(0xFFFFD48A), // 7
  Color(0xFFCCCCCC), // 8
  Colors.white, // 9
  Colors.black, // 10
  Colors.grey.shade600, // 11
  Colors.grey.shade400, // 12
  Colors.grey, // 13
  Colors.grey.shade700, // 14
  Colors.grey.shade100, // 15
  Color(0xFF90A4AE), // 16
  Color(0xFFFAFAFA), //17
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0}) : 
    assert(
      selectedColor >= 0 && selectedColor <= colorThemes.length - 1, 
      "colors most be between 0 and ${colorThemes.length}"
    );

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colorThemes[selectedColor],
      brightness: Brightness.dark,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
      ),
    );
  }
}