// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/split_day/update_split_day/update_split_day_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/split_day/update_split_day/update_split_day_response.dart';
import 'package:routines_gym_app/provider/split_day/split_day_provider.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';
import 'package:provider/provider.dart';

class EditSplitDaysBottomSheet extends StatefulWidget {
  final RoutineDTO routine;
  final String userEmail;
  final VoidCallback onSplitDaysUpdated;

  const EditSplitDaysBottomSheet({
    super.key,
    required this.routine,
    required this.userEmail,
    required this.onSplitDaysUpdated,
  });

  @override
  State<EditSplitDaysBottomSheet> createState() => _EditSplitDaysBottomSheetState();
}

class _EditSplitDaysBottomSheetState extends State<EditSplitDaysBottomSheet> {
  final List<String> weekDays = [
    "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
  ];

  // 0 = neutro, 1 = agregar (verde), -1 = eliminar (rojo)
  late Map<String, int> dayStates;
  Set<String> currentRoutineDays = {};

  @override
  void initState() {
    super.initState();

    // Inicializamos los días que ya están en la rutina
    currentRoutineDays = widget.routine.splitDays.isNotEmpty
        ? widget.routine.splitDays.map((d) => d.name).toSet()
        : <String>{};

    dayStates = { for (var day in weekDays) day: 0 };
  }

  void toggleDay(String day) {
    setState(() {
      if (currentRoutineDays.contains(day)) {
        // El día ya está en la rutina
        dayStates[day] = (dayStates[day] == -1) ? 0 : -1;
      } else {
        // El día NO está en la rutina
        dayStates[day] = (dayStates[day] == 1) ? 0 : 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final splitDayProvider = Provider.of<SplitDayProvider>(context, listen: false);

    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Handle superior
            Center(
              child: Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const Text(
              "Edit Split Days",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
            ),
            const SizedBox(height: 16),

            // Grid de días
            Expanded(
              child: GridView.count(
                controller: controller,
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.4,
                children: weekDays.map((day) {
                  final state = dayStates[day]!;
                  late Color color;

                  if (state == 1) {
                    color = Colors.green;
                  } else if (state == -1) {
                    color = Colors.red;
                  } else {
                    color = Colors.grey.shade600;
                  }

                  return GestureDetector(
                    onTap: () => toggleDay(day),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: color, width: 1.5),
                      ),
                      child: Text(
                        day,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 12),

            // Botón Guardar
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              label: const Text("Save Changes"),
              onPressed: () async {
                final addDays = dayStates.entries
                    .where((e) => e.value == 1)
                    .map((e) => e.key)
                    .toList();

                final deleteDays = dayStates.entries
                    .where((e) => e.value == -1)
                    .map((e) => e.key)
                    .toList();

                final UpdateSplitDayRequest updateSplitDayRequest = UpdateSplitDayRequest(
                  routineName: widget.routine.routineName,
                  userEmail: widget.userEmail,
                  addDays: addDays,
                  deleteDays: deleteDays,
                );

                try {
                  final UpdateSplitDayResponse response = await splitDayProvider.updateSplitDay(updateSplitDayRequest);

                  if (response.isSuccess == true) {
                    ToastMessage.showToast(response.message ?? "Split days updated");
                    widget.onSplitDaysUpdated();
                    Navigator.pop(context);
                  } else {
                    ToastMessage.showToast(response.message ?? "Error updating split days");
                  }
                } catch (e) {
                  ToastMessage.showToast("Error updating split days");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
