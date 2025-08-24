// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/add_exercise/add_exercise_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/add_exercise/add_exercise_response.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:routines_gym_app/provider/exercise/exercise_provider.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class AddExerciseBottomSheet extends StatelessWidget {
  final TextEditingController controller;
  final String routineName;
  final String dayName;
  final VoidCallback onExerciseAdded; 

  const AddExerciseBottomSheet({
    super.key,
    required this.controller,
    required this.routineName,
    required this.dayName,
    required this.onExerciseAdded, 
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colorThemes[9],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add New Exercise',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorThemes[14],
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: 'Exercise name',
              icon: Icons.drive_file_rename_outline, 
              controller: controller,
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () async {
                final ExerciseProvider exerciseProvider = ExerciseProvider();
                String exerciseName = controller.text.trim();

                if (exerciseName.isNotEmpty) {
                  AddExerciseRequest addExerciseRequest = AddExerciseRequest(
                    routineName: routineName,
                    exerciseName: exerciseName,
                    dayName: dayName,
                  );

                  AddExerciseResponse addExerciseResponse =
                      await exerciseProvider.addExercise(addExerciseRequest);

                  if (addExerciseResponse.isSuccess!) {
                    onExerciseAdded();
                    Navigator.pop(context);
                  }

                  ToastMessage.showToast(addExerciseResponse.message!);
                } else {
                  ToastMessage.showToast('Please enter an exercise name');
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Save Exercise',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}