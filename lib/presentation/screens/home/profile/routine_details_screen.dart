import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/split_day_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_by_id/get_routine_by_id_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_by_id/get_routine_by_id_response.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/widgets/cards/exercise/exercise_card.dart';
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
  RoutineDTO? routine;
  int? selectedDayIndex;
  Map<int, List<ExerciseCard>> exercisesByDay = {};

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
        debugPrint('Day: ${day.name}, Enum: ${day.dayName}');
        final dayIndex = day.dayName.index;
        exercisesByDay[dayIndex] = [];
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo cargar la rutina")),
      );
    }

    setState(() {});
  }

  void _onDaySelected(int index) {
    setState(() {
      selectedDayIndex = selectedDayIndex == index ? null : index;
    });
  }

  void _addExercise(int dayIndex) {
    final newCard = ExerciseCard(
      ctrls: {},
      showRemove: true,
      onRemove: () => _removeExercise(dayIndex, exercisesByDay[dayIndex]!.length),
    );

    setState(() {
      exercisesByDay[dayIndex]!.add(newCard);
    });
  }

  void _removeExercise(int dayIndex, int index) {
    setState(() {
      exercisesByDay[dayIndex]!.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorThemes[17],
      appBar: AppBar(
        title: Text(routine?.routineName ?? "Routine"),
        backgroundColor: colorThemes[17],
        elevation: 0,
      ),
      body: routine == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              children: [
                Text(
                  'Select the day',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                _buildDaySelector(routine!.splitDays),
                const SizedBox(height: 24),
                if (selectedDayIndex != null)
                  _buildExercisesByDay(routine!.splitDays[selectedDayIndex!]),
              ],
            ),
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
        
        // Usamos el nombre del día directamente desde el DTO
        final dayName = day.name;
        
        // Para debugging, imprimimos el nombre
        debugPrint('Day $index: $dayName');

        return SizedBox(
          width: 120,
          height: 48,
          child: FilterChip(
            label: SizedBox(
              width: 102,
              child: Text(
                dayName,
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
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorThemes[17],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  day.name, 
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: colorThemes[7],
                  size: 28,
                ),
                tooltip: 'Add exercise',
                onPressed: () => _addExercise(dayIndex),
              ),
            ],
          ),
        ),
        ...exercises.asMap().entries.map((entry) => Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ExerciseCard(
                ctrls: entry.value.ctrls,
                showRemove: exercises.length > 1,
                onRemove: () => _removeExercise(dayIndex, entry.key),
              ),
            )),
      ],
    );
  }
}