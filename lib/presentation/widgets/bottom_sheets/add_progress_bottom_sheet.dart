// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/exercise_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/add_exercise_progress/add_exercise_progress_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/add_exercise_progress/add_exercise_progress_response.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:routines_gym_app/provider/exercise/exercise_provider.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class AddProgressBottomSheet extends StatelessWidget {
  final ExerciseDTO exercise;
  final RoutineDTO? routine;
  final VoidCallback? onProgressAdded; 

  const AddProgressBottomSheet({
    super.key,
    required this.exercise,
    required this.routine,
    this.onProgressAdded,
  });

  @override
  Widget build(BuildContext context) {
    final setsController = TextEditingController();
    final repsController = TextEditingController();
    final weightController = TextEditingController();


    return StatefulBuilder(
      builder: (context, setState) {

        return Container(
          decoration: BoxDecoration(
            color: colorThemes[9],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: colorThemes[12],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  'Add progress to ${exercise.exerciseName}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: colorThemes[14],
                      ),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  hintText: 'Sets',
                  icon: Icons.fitness_center,
                  keyboardType: TextInputType.number,
                  controller: setsController,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: 'Repetitions',
                  icon: Icons.repeat,
                  keyboardType: TextInputType.number,
                  controller: repsController,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: 'Weight (kg)',
                  icon: Icons.scale,
                  keyboardType: TextInputType.number,
                  controller: weightController,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check),
                    label: const Text(
                      'Confirm',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorThemes[6],
                      foregroundColor: Colors.white, 
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      shadowColor: Colors.black26,
                    ),
                    onPressed: () async {
                      final sets = setsController.text.trim();
                      final reps = repsController.text.trim();
                      final weight = weightController.text.trim();

                      if (sets.isEmpty || reps.isEmpty || weight.isEmpty) {
                        ToastMessage.showToast("Please fill in all fields");
                        return;
                      }

                      ExerciseProvider exerciseProvider = ExerciseProvider();
                      AddExerciseProgressRequest request = AddExerciseProgressRequest(
                        routineId: exercise.routineId,
                        splitDayId: exercise.splitDayId,
                        exerciseName: exercise.exerciseName,
                        progressList: [sets, reps, weight],
                      );

                      AddExerciseProgressResponse response =
                          await exerciseProvider.addExerciseProgress(request);

                      ToastMessage.showToast(response.message ?? "");

                      if (response.isSuccess == true) {
                        onProgressAdded?.call(); 
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}