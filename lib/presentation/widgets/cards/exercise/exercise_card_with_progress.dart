import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/exercise_dto.dart';

class ExerciseCardWithProgress extends StatelessWidget {
  final ExerciseDTO exercise;
  final List<String> progress;

  const ExerciseCardWithProgress({
    super.key,
    required this.exercise,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final lastProgress = progress.isNotEmpty ? progress.last : "Sin registros";

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise.exerciseName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.fitness_center, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  'Último progreso: $lastProgress',
                  style: TextStyle(color: Colors.black87),
                ),
              ],
            ),
            if (progress.length > 1)
              ExpansionTile(
                title: Text(
                  'Ver historial',
                  style: TextStyle(fontSize: 13, color: Colors.blueAccent),
                ),
                children: progress
                    .map((p) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(p),
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}