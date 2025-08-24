// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/screens/home/social/friend_routine_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoutinesListView extends StatelessWidget {
  final List<RoutineDTO> routines;

  const RoutinesListView({super.key, required this.routines});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: routines.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final routine = routines[index];
        return Container(
          decoration: BoxDecoration(
            color: colorThemes[9], 
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD6CBB8), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              radius: 22,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: colorThemes[9],
                child: Image.asset(
                  'assets/icons/training_icon.png', 
                  width: 40,
                  height: 40,
                  color: Colors.black, 
                ),
              ),
            ),
            title: Text(
              routine.routineName,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: colorThemes[10],
              ),
            ),
            subtitle: (routine.routineDescription.isNotEmpty)
                ? Text(
                    routine.routineDescription,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  )
                : null,
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => FriendRoutineDetailScreen(
                  routineName: routine.routineName,
                  userEmail: prefs.getString("userEmail") ?? "" 
                ))
              );
            },
          ),
        );
      },
    );
  }
}