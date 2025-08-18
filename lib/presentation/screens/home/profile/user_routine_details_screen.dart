import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';

class UserRoutineDetailsScreen extends StatelessWidget {
  final RoutineDTO routine;
  final String userEmail;

  const UserRoutineDetailsScreen({
    super.key,
    required this.routine,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(routine.routineName)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Created by: $userEmail",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              routine.routineDescription,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
