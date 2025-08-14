import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/controller/stats/steps_tracker.dart';
import 'package:routines_gym_app/presentation/widgets/cards/stats/step_progress_card.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorThemes[17],
      appBar: _appBar(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          StepProgressCard(
            currentSteps: context.watch<StepTracker>().stepsToday,
            dailyGoal: context.watch<StepTracker>().dailyGoal,
          ),
          const SizedBox(height: 20),
        ],
      )
    );
  }

    AppBar _appBar() {
    return AppBar(
      title: const Text("Stats"),
      titleTextStyle: TextStyle(
        color: colorThemes[10],
        fontSize: 27,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: colorThemes[17],
      elevation: 0,
    );
  }
}