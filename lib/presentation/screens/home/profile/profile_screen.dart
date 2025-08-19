// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_all_user_routines/get_all_user_routines_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_all_user_routines/get_all_user_routines_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/get/get_user_by_email/get_user_by_email_response.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/presentation/screens/home/profile/user_routine_details_screen.dart';
import 'package:routines_gym_app/presentation/widgets/bottom_sheets/settings_bottom_sheet/profile_settings_bottom_sheet.dart';
import 'package:routines_gym_app/provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<List<RoutineDTO>> _routinesFuture;
  final RoutineProvider _routineProvider = RoutineProvider();

  @override
  void initState() {
    super.initState();
    _routinesFuture = _fetchRoutines();
  }

  Future<List<RoutineDTO>> _fetchRoutines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GetAllUserRoutinesRequest getAllUserRoutinesRequest = GetAllUserRoutinesRequest(
      userEmail: prefs.getString("userEmail") ?? ""
    );

    GetAllUserRoutinesResponse getAllUserFriendsResponse = await _routineProvider.getAllUserRoutines(getAllUserRoutinesRequest);
    return getAllUserFriendsResponse.routines ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorThemes[17],
      appBar: _appBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _UserDataSection(),
            const SizedBox(height: 20),

            const Divider(color: Color(0xFFD6CBB8), thickness: 1),
            const SizedBox(height: 25),

            Text(
              "My Routines",
              style: TextStyle(
                color: colorThemes[10],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            _RoutinesListView(routinesFuture: _routinesFuture),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
  return AppBar(
    title: const Text("Profile"),
    titleTextStyle: TextStyle(
      color: colorThemes[10],
      fontSize: 27,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: colorThemes[17],
    elevation: 0,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: IconButton(
          icon: const Icon(Icons.settings),
          color: colorThemes[10],
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: colorThemes[17],
              builder: (context) => ProfileSettingsBottomSheet(
                onSelected: (value) {
                  debugPrint('Seleccionaste: $value');
                },
              ),
            );
          },
        ),
      ),
    ],
  );
}

}

class _RoutinesListView extends StatelessWidget {
  const _RoutinesListView({
    required Future<List<RoutineDTO>> routinesFuture,
  }) : _routinesFuture = routinesFuture;

  final Future<List<RoutineDTO>> _routinesFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RoutineDTO>>(
      future: _routinesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error loading routines",
              style: TextStyle(color: Colors.red.shade400),
            ),
          );
        }
        final routines = snapshot.data ?? [];
        if (routines.isEmpty) {
          return const Center(
            child: Text(
              "You haven't created any routines yet.",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          );
        }
    
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: routines.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final routine = routines[index];
            return _RoutineCard(routine: routine);
          },
        );
      },
    );
  }
}

class _UserDataSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = UserProvider();

    return FutureBuilder<GetUserByEmailResponse>(
      future: userProvider.getUserByEmail(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || !snapshot.hasData || !(snapshot.data?.isSuccess ?? false)) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              "Error loading user data",
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        final user = snapshot.data!.userDTO;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 40, color: Colors.white),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.username ?? "Unknown User",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user?.email ?? "no-email",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class _RoutineCard extends StatelessWidget {
  final RoutineDTO routine;
  const _RoutineCard({required this.routine});

  Future<String> _getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("userEmail") ?? "no-email";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () async {
        final email = await _getUserEmail();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserRoutineDetailsScreen(
              routine: routine,
              userEmail: email,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorThemes[9],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              routine.routineName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (routine.routineDescription.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  routine.routineDescription,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}