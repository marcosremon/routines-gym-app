import 'package:flutter/material.dart';

const Color _colorTheme = Color(0xFF49149F);

const List<Color> _colorThemes = [
  _colorTheme,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
  Color(0xFFFBC369), 
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0}) : 
    assert(
      selectedColor >= 0 && selectedColor <= _colorThemes.length - 1, 
      "colors most be between 0 and ${_colorThemes.length}"
    );

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[selectedColor],
      brightness: Brightness.dark,
    );
  }
}