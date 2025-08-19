import 'package:flutter/material.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/controller/stats/steps_tracker.dart';

class DailyStepsGoalBottomSheet extends StatelessWidget {
  final StepTracker stepTracker;

  const DailyStepsGoalBottomSheet({super.key, required this.stepTracker});

  @override
  Widget build(BuildContext context) {
    int tempGoal = stepTracker.dailyGoal;

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(35),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Change daily goal',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '$tempGoal steps',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              Slider(
                value: tempGoal.toDouble(),
                min: 1000,
                max: 30000,
                divisions: 29,
                label: '$tempGoal',
                activeColor: colorThemes[7],
                inactiveColor: Colors.blue.shade100,
                onChanged: (value) {
                  setState(() {
                    tempGoal = value.round();
                  });
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    stepTracker.setDailyGoal(tempGoal);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.check),
                  label: const Text(
                    'Save goal',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorThemes[16],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}