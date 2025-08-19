import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/domain/model/entities/stat.dart';
import 'package:routines_gym_app/presentation/controller/stats/steps_tracker.dart';
import 'package:routines_gym_app/presentation/widgets/cards/stats/step_progress_card.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StepTracker stepTracker = Provider.of<StepTracker>(context);

    return Scaffold(
      backgroundColor: colorThemes[17],
      appBar: _appBar(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          StepProgressCard(
            currentSteps: stepTracker.stepsToday,
            dailyGoal: stepTracker.dailyGoal,
            stepTracker: stepTracker,
          ),
          const SizedBox(height: 30),

          _buildStatsList(stepTracker),
        ],
      ),
    );
  }

  Widget _buildStatsList(StepTracker stepTracker) {
    final List<Stats> completeDays = stepTracker.completeDays;

    if (completeDays.isEmpty) {
      return const Center(
        child: Text(
          "No data available",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: completeDays.length,
      separatorBuilder: (_, _) => const Divider(color: Colors.grey),
      itemBuilder: (context, index) {
        final stat = completeDays[index];
        return ListTile(
          leading: const Icon(Icons.calendar_today, color: Colors.white),
          title: Text(
            DateFormat('dd/MM/yyyy').format(stat.date),
            style: TextStyle(
              color: colorThemes[10],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            "${stat.steps} steps",
            style: TextStyle(
              color: colorThemes[10],
              fontSize: 16,
            ),
          ),
        );
      },
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