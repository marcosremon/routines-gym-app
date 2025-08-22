import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/get_exercises_by_day_and_routine_id/get_exercises_by_day_and_routine_id_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/get_exercises_by_day_and_routine_id/get_exercises_by_day_and_routine_id_response.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/provider/exercise/exercise_provider.dart';
import 'package:routines_gym_app/transversal/utils/app_utils.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class RoutineDetailScreen extends StatefulWidget {
  final RoutineDTO routine;
  final String userEmail;

  const RoutineDetailScreen({
    super.key,
    required this.routine,
    required this.userEmail,
  });

  @override
  State<RoutineDetailScreen> createState() => _RoutineDetailScreenState();
}

class _RoutineDetailScreenState extends State<RoutineDetailScreen> {
  late ExerciseProvider exerciseProvider;
  int? selectedDayIndex;

  @override
  void initState() {
    super.initState();
    exerciseProvider = Provider.of<ExerciseProvider>(context, listen: false);
  }

  Future<void> _loadExercisesForDay(int dayIndex) async {
    selectedDayIndex = dayIndex;
    GetExercisesByDayAndRoutineIdRequest request = GetExercisesByDayAndRoutineIdRequest(
      routineName: widget.routine.routineName, 
      dayName: AppUtils.getDayName(dayIndex),
    );

    GetExercisesByDayAndRoutineIdResponse response =
        await exerciseProvider.getExercisesByDayAndRoutineId(request);

    ToastMessage.showToast(response.message ?? "");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final routine = widget.routine;

    return Scaffold(
      appBar: AppBar(
        title: Text(routine.routineName),
        backgroundColor: colorThemes[17],
        elevation: 0,
      ),
      backgroundColor: colorThemes[17],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDaySelector(
              routine.splitDays
                      .map((day) => day.dayName.index) 
                      .toList(),
            ),
            const SizedBox(height: 16),
            if (selectedDayIndex != null) _buildProgressSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDaySelector(List<int> splitDays) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      childAspectRatio: 2.6,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: splitDays.map((dayIndex) {
        final isSelected = selectedDayIndex == dayIndex;
        return FilterChip(
          label: Text(
            AppUtils.getDayName(dayIndex),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? colorThemes[9] : Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 11.5,
            ),
          ),
          selected: isSelected,
          onSelected: (_) => _loadExercisesForDay(dayIndex),
          backgroundColor: colorThemes[9],
          selectedColor: colorThemes[7],
          checkmarkColor: colorThemes[9],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isSelected ? colorThemes[7] : Colors.grey.shade300,
              width: 1,
            ),
          ),
          padding: EdgeInsets.zero,
          labelPadding: const EdgeInsets.symmetric(horizontal: 0),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      }).toList(),
    );
  }

  Widget _buildProgressSection() {
    final response = exerciseProvider.exerciseProgressResponse;

    if (response == null || response.exercises.isEmpty) {
      return const Text("No exercises found for this day.");
    }

    final exercises = response.exercises;
    final progressMap = response.pastProgress;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: exercises.asMap().entries.map((entry) {
        final index = entry.key;
        final exercise = entry.value;

        final progress = progressMap.values.elementAt(index);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.exerciseName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                ...progress.asMap().entries.map((e) => Text(
                      "Week ${e.key + 1}: ${e.value}",
                      style: const TextStyle(fontSize: 14),
                    )),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}