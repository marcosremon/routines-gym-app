import 'package:flutter/material.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/widgets/text_fields/custom_text_field.dart';

class ExerciseCard extends StatelessWidget {
  final Map<String, TextEditingController> ctrls;
  final VoidCallback? onRemove;
  final bool showRemove;

  const ExerciseCard({
    super.key,
    required this.ctrls,
    this.onRemove,
    this.showRemove = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colorThemes[17],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: ctrls["exerciseName"]!,
                    hintText: 'Exercise',
                    icon: Icons.sports_gymnastics,
                  ),
                ),
                if (showRemove)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onRemove,
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: ctrls["sets"]!,
                    hintText: 'Sets',
                    icon: Icons.repeat,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    controller: ctrls["reps"]!,
                    hintText: 'Reps',
                    icon: Icons.repeat_one,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    controller: ctrls["weight"]!,
                    hintText: 'Weight',
                    icon: Icons.monitor_weight,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}