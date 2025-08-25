import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/domain/model/entities/stat.dart';
import 'package:routines_gym_app/presentation/controller/stats/steps_tracker.dart';
import 'package:routines_gym_app/presentation/widgets/cards/stats/step_progress_card.dart';

import 'package:provider/provider.dart'; // Asegúrate de importar esto

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorThemes[17],
      appBar: _appBar(),
      body: Consumer<StepTracker>(
        builder: (context, stepTracker, _) {
          final statsList = stepTracker.completeDays;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              StepProgressCard(
                currentSteps: stepTracker.stepsToday,
                dailyGoal: stepTracker.dailyGoal,
              ),
              const SizedBox(height: 30),
              Text(
                "Daily History",
                style: TextStyle(
                  color: colorThemes[10],
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildStatsList(statsList),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatsList(List<Stats> statsList) {
    if (statsList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 40),
        child: Center(
          child: Text(
            "No data available yet",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: statsList.length,
      itemBuilder: (context, index) {
        final stat = statsList[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: colorThemes[16],
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_month, color: Colors.white, size: 28),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('EEEE').format(stat.date),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          DateFormat('dd MMMM yyyy').format(stat.date),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.directions_walk, color: Colors.white, size: 24),
                    const SizedBox(height: 4),
                    Text(
                      "${stat.steps} steps",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
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
