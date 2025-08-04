// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';

class TrainingStatCard extends StatefulWidget {
  final Widget icon;
  final String label;
  final int initialCount;

  const TrainingStatCard({
    super.key,
    required this.icon,
    required this.label,
    this.initialCount = 0,
  });

  @override
  State<TrainingStatCard> createState() => _TrainingStatCardState();
}

class _TrainingStatCardState extends State<TrainingStatCard> {
  late int count;
  final Color generalColor = colorThemes[10];

  @override
  void initState() {
    super.initState();
    count = widget.initialCount;
  }

  void updateCount(int newValue) {
    setState(() {
      count = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: generalColor.withOpacity(0.10),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: generalColor.withOpacity(0.06),
            blurRadius: 2,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 40, height: 40, child: widget.icon),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 18,
                color: generalColor,
              ),
            ),
          ),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: generalColor,
            ),
          ),
        ],
      ),
    );
  }
}