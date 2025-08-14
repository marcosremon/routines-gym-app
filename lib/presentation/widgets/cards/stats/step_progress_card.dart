import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/controller/stats/steps_tracker.dart';
import 'package:routines_gym_app/presentation/widgets/bottom_sheets/daily_goal_bottom_sheet.dart';

class StepProgressCard extends StatelessWidget {
  final int currentSteps;
  final int dailyGoal;
  final StepTracker stepTracker;

  const StepProgressCard({
    super.key,
    required this.currentSteps,
    required this.dailyGoal,
    required this.stepTracker,
  });


  @override
  Widget build(BuildContext context) {
    double percent = (currentSteps / dailyGoal).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: colorThemes[9],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: CircularPercentIndicator(
          radius: 100,
          lineWidth: 15,
          percent: percent,
          animation: true,
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Colors.greenAccent,
          backgroundColor: Colors.grey.shade300,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$currentSteps',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: colorThemes[10],
                ),
              ),
             TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white, 
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => DailyGoalBottomSheet(stepTracker: stepTracker),
                  );
                },
                child: Text(
                  'Goal of $dailyGoal',
                  style: TextStyle(
                    fontSize: 16,
                    color: colorThemes[10],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}