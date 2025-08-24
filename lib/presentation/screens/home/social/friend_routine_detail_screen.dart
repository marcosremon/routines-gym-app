// ignore_for_file: use_build_context_synchronously, collection_methods_unrelated_type

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/split_day_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/exercise_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_by_id/get_routine_by_id_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_by_id/get_routine_by_id_response.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/provider/routine/routine_provider.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class FriendRoutineDetailScreen extends StatefulWidget {
  final String routineName;
  final String userEmail;

  const FriendRoutineDetailScreen({
    super.key,
    required this.routineName,
    required this.userEmail,
  });

  @override
  State<FriendRoutineDetailScreen> createState() => _FriendRoutineDetailScreenState();
}

class _FriendRoutineDetailScreenState extends State<FriendRoutineDetailScreen> {
  late RoutineProvider routineProvider;
  RoutineDTO? routine;
  int? selectedDayIndex;

  Map<int, List<Map<String, dynamic>>> exercisesByDay = {};

  @override
  void initState() {
    super.initState();
    routineProvider = Provider.of<RoutineProvider>(context, listen: false);
    _loadRoutine();
  }

  Future<void> _loadRoutine() async {
    final request = GetRoutineByRoutineNameRequest(
      routineName: widget.routineName,
    );

    final GetRoutineByRoutineNameResponse response = await routineProvider.getRoutineByRoutineName(request);
    if (response.routineDTO != null) {
      routine = response.routineDTO;
      for (var day in routine!.splitDays) {
        exercisesByDay[day.dayName.index] = [];
      }
    } else {
      ToastMessage.showToast("The routine could not be loaded");
    }

    setState(() {});
  }

  void _onDaySelected(int index) {
    setState(() {
      if (selectedDayIndex == index) {
        selectedDayIndex = null;
      } else {
        selectedDayIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorThemes[17],
      appBar: _appBar(),
      body: routine == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select the day',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildDaySelector(routine!.splitDays),
                    ],
                  ),
                ),
                const Divider(color: Color(0xFFD6CBB8), thickness: 1),
                const SizedBox(height: 15),
                Expanded(
                  child: selectedDayIndex == null
                      ? _buildEmptyState()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          child: _buildExercisesByDay(routine!.splitDays[selectedDayIndex!]),
                        ),
                ),
              ],
            ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: colorThemes[17],
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Routine details",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: false,
    );
  }

  Widget _buildDaySelector(List<SplitDayDTO> splitDays) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      childAspectRatio: 2.6,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: splitDays.asMap().entries.map((entry) {
        final index = entry.key;
        final day = entry.value;
        final isSelected = selectedDayIndex == index;

        return SizedBox(
          width: 120,
          height: 48,
          child: FilterChip(
            label: SizedBox(
              width: 102,
              child: Text(
                day.name,
                style: TextStyle(
                  color: isSelected ? colorThemes[9] : Colors.black87,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
            selected: isSelected,
            onSelected: (_) => _onDaySelected(index),
            backgroundColor: colorThemes[9],
            selectedColor: colorThemes[6],
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
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExercisesByDay(SplitDayDTO day) {
    final dayIndex = day.dayName.index;
    final exercises = exercisesByDay[dayIndex] ?? [];

    return ListView.separated(
      itemCount: exercises.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final exerciseData = exercises[index];
        final ExerciseDTO exercise = exerciseData['exercise'];
        final List<String> progress = exerciseData['progress'];
        final lastThree = progress.reversed.take(3).toList();

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.exerciseName.isNotEmpty ? exercise.exerciseName : "Unnamed Exercise",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Recent Progress:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),
                if (progress.isEmpty)
                  Text(
                    'No progress recorded yet',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                else
                  Column(
                    children: [
                      if (lastThree.isNotEmpty) _buildProgressItem('Latest', lastThree[0], true),
                      if (lastThree.length > 1) _buildProgressItem('Second', lastThree[1], false),
                      if (lastThree.length > 2) _buildProgressItem('Third', lastThree[2], false),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressItem(String label, String progress, bool isLatest) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: isLatest ? colorThemes[7] : Colors.grey.shade400,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 15,
              fontWeight: isLatest ? FontWeight.w600 : FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              progress,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isLatest ? FontWeight.w600 : FontWeight.w600,
                color: isLatest ? Colors.grey.shade700 : Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 110),
          Icon(
            Icons.calendar_month_sharp,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 20),
          Text(
            "Select a day to view exercises",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Choose from the days above to see the workout plan",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
