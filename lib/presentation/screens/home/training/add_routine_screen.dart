import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/controller/routine_controller.dart';
import 'package:routines_gym_app/presentation/widgets/buttons/custom_button.dart';
import 'package:routines_gym_app/presentation/widgets/cards/exercise/exercise_card.dart';
import 'package:routines_gym_app/presentation/widgets/text_fields/custom_text_field.dart';

class AddRoutineScreen extends StatelessWidget {
  const AddRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RoutineController routineController = Provider.of<RoutineController>(context);

    return Scaffold(
      backgroundColor: colorThemes[17],
      appBar: _appBar(context),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        children: [
          CustomTextField(
            hintText: "Routine name", 
            controller: routineController.nameController,
            icon: Icons.fitness_center,
          ),
          const SizedBox(height: 16),
          
          CustomTextField(
            hintText: "Routine description (optional)", 
            controller: routineController.descController,
            icon: Icons.description,
          ),
          const SizedBox(height: 24),

          Text(
            'Select the days',
            style: TextStyle(
              color: Colors.black38,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),

          _buildDaySelector(routineController),
          const SizedBox(height: 24),
          
          ..._buildExercisesByDay(routineController, context),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
        child: CustomButton(
          text: 'Create routine',
          textColor: colorThemes[9],
          onPressed: () {
            routineController.submitRoutine(context);
          },
    ),
  ),

    );
  }

  Widget _buildDaySelector(RoutineController controller) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      childAspectRatio: 2.6,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: List.generate(7, (day) => _buildDayChip(controller, day)),
    );
  }

  Widget _buildDayChip(RoutineController controller, int day) {
    final isSelected = controller.selectedDays.contains(day);
    return SizedBox(
      width: 120, 
      height: 48,
      child: FilterChip(
        label: SizedBox(
          width: 102, 
          child: Text(
            controller.weekDays[day],
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
        onSelected: (_) => controller.toggleDay(day),
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
  }

  List<Widget> _buildExercisesByDay(RoutineController controller, BuildContext context) {
    return controller.selectedDays.map((day) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
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
                  controller.weekDays[day],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontSize: 16, 
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.add, 
                  color: colorThemes[7],
                  size: 28, 
                ),
                tooltip: 'Add exercise',
                onPressed: () => controller.addExercise(day),
              ),
            ],
          ),
        ),
        ...controller.exercisesByDay[day]!.asMap().entries.map((entry) => 
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ExerciseCard(
              ctrls: entry.value,
              showRemove: controller.exercisesByDay[day]!.length > 1,
              onRemove: () => controller.removeExercise(day, entry.key),
            ),
          ),
        ),
      ],
    )).toList();
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: colorThemes[17],
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Add new routine",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: false,
    );
  }
}