import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText; // ← ahora es nullable, sin valor por defecto

  const CustomPasswordField({
    super.key,
    this.controller,
    this.hintText, // ← ya no tiene valor por defecto
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
       style: TextStyle(
        color: Colors.grey[700],
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey[600],
          ),
          onPressed: _toggleVisibility,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFCCCCCC),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFCCCCCC),
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