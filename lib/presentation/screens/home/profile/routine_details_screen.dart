// ignore_for_file: use_build_context_synchronously, collection_methods_unrelated_type

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/split_day_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/exercise_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/exercise/get_exercises_by_day_and_routine_id/get_exercises_by_day_and_routine_id_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_by_id/get_routine_by_id_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_by_id/get_routine_by_id_response.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/widgets/bottom_sheets/add_progress_bottom_sheet.dart';
import 'package:routines_gym_app/provider/exercise/exercise_provider.dart';
import 'package:routines_gym_app/provider/routine/routine_provider.dart';

class RoutineDetailScreen extends StatefulWidget {
  final String routineName;
  final String userEmail;

  const RoutineDetailScreen({
    super.key,
    required this.routineName,
    required this.userEmail,
  });

  @override
  State<RoutineDetailScreen> createState() => _RoutineDetailScreenState();
}

class _RoutineDetailScreenState extends State<RoutineDetailScreen> {
  late RoutineProvider routineProvider;
  late ExerciseProvider exerciseProvider;
  RoutineDTO? routine;
  int? selectedDayIndex;

  Map<int, List<Map<String, dynamic>>> exercisesByDay = {};

  @override
  void initState() {
    super.initState();
    routineProvider = Provider.of<RoutineProvider>(context, listen: false);
    exerciseProvider = Provider.of<ExerciseProvider>(context, listen: false);
    _loadRoutine();
  }

  Future<void> _loadRoutine() async {
    final request = GetRoutineByRoutineNameRequest(
      routineName: widget.routineName,
    );

    final GetRoutineByRoutineNameResponse response =
        await routineProvider.getRoutineByRoutineName(request);

    if (response.routineDTO != null) {
      routine = response.routineDTO;
      for (var day in routine!.splitDays) {
        exercisesByDay[day.dayName.index] = [];
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo cargar la rutina")),
      );
    }

    setState(() {});
  }

  Future<void> _onDaySelected(int index) async {
    if (selectedDayIndex == index) {
      setState(() {
        selectedDayIndex = null;
      });
      return;
    }

    final selectedDay = routine!.splitDays[index];

    final request = GetExercisesByDayAndRoutineNameRequest(
      dayName: selectedDay.dayName.name,
      routineName: routine!.routineName,
    );

    try {
      final response = await exerciseProvider.getExercisesByDayAndRoutineName(request);

      if (response.isSuccess! && response.exercises.isNotEmpty) {
        selectedDayIndex = index;

        // ✅ CORRECCIÓN: Mapear cada ejercicio con su progress correspondiente por índice
        exercisesByDay[index] = response.exercises.asMap().entries.map((entry) {
          final exerciseIndex = entry.key;
          final exercise = entry.value;
          
          // Obtener el progress correspondiente por índice
          final progressKeys = response.pastProgress.keys.toList();
          final progressList = exerciseIndex < progressKeys.length 
              ? response.pastProgress[progressKeys[exerciseIndex]] ?? []
              : [];

          return {
            'exercise': exercise,
            'progress': progressList,
          };
        }).toList();

        setState(() {});
      } else {
        setState(() {
          selectedDayIndex = index;
          exercisesByDay[index] = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message ?? 'No se encontraron ejercicios')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al cargar los ejercicios')),
      );
    }
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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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

                Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(15, 0, 15, 0), 
                  child: const Divider(
                    color: Color(0xFFD6CBB8), 
                    thickness: 1
                  )
                ),
                const SizedBox(height: 15),

                Expanded(
                  child: selectedDayIndex == null
                      ? _buildEmptyState()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          child: _buildExercisesByDay(
                              routine!.splitDays[selectedDayIndex!]),
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
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExercisesByDay(SplitDayDTO day) {
    final dayIndex = day.dayName.index;
    final exercises = exercisesByDay[dayIndex]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Exercises for ${day.name}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            IconButton(
              icon: Icon(Icons.add_circle_outline, 
                  color: colorThemes[6], size: 28),
              tooltip: 'add exercise',
              onPressed: () {} // to_do
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              exercise.exerciseName.isNotEmpty
                                  ? exercise.exerciseName
                                  : "Unnamed Exercise",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: colorThemes[6],
                              size: 28,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                  ),
                                  child: AddProgressBottomSheet(
                                    exercise: exercise,
                                    routine: routine,
                                    onProgressAdded: () async {
                                      await _onDaySelected(selectedDayIndex!);
                                    },
                                  ),
                                ),
                              );
                            },
                          )
                        ],
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
                            if (lastThree.isNotEmpty)
                              _buildProgressItem('Latest', lastThree[0], true),
                            
                            if (lastThree.length > 1)
                              _buildProgressItem('Second', lastThree[1], false),
                            
                            if (lastThree.length > 2)
                              _buildProgressItem('Third', lastThree[2], false),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
            "Choose from the days above to see your workout plan",
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