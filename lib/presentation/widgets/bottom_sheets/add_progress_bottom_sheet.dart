// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/exercise_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/widgets/text_fields/custom_text_field.dart';

class AddProgressBottomSheet extends StatelessWidget {
  final ExerciseDTO exercise;
  final RoutineDTO? routine;

  const AddProgressBottomSheet({
    super.key,
    required this.exercise,
    required this.routine,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController setsController = TextEditingController();
    final TextEditingController repsController = TextEditingController();
    final TextEditingController weightController = TextEditingController();

    return Scaffold(
      backgroundColor: colorThemes[9], // Fondo blanco
      appBar: AppBar(
        backgroundColor: colorThemes[9],
        elevation: 0,
        iconTheme: IconThemeData(color: colorThemes[14]), // iconos oscuros
        title: Text(
          'Add Progress',
          style: TextStyle(
            color: colorThemes[14],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StatefulBuilder(
        builder: (context, setState) {
          bool isValid = false;

          void checkValid() {
            setState(() {
              isValid = setsController.text.isNotEmpty &&
                  repsController.text.isNotEmpty &&
                  weightController.text.isNotEmpty;
            });
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    label: const Text('Confirm'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isValid
                          ? colorThemes[7] 
                          : colorThemes[12].withOpacity(0.6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    onPressed: isValid
                        ? () {
                            // Guardar progreso
                            Navigator.pop(context);
                          }
                        : null,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
