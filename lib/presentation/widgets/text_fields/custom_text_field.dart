import 'package:flutter/material.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller; 

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return TextField(
      controller: controller, 
      obscureText: obscureText,
      keyboardType: keyboardType,
       style: TextStyle(
        color: colorThemes[14], // grey 700
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: colorThemes[9], // white
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: colorThemes[12], // grey 400
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: colorThemes[12], // grey 400
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: primaryColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
