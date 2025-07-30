import 'package:flutter/material.dart';

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
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFFFBC369), Color(0xFFFFD48A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}