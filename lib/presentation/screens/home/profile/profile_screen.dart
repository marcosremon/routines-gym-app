// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/delete_routine/delete_routine_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/delete_routine/delete_routine_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_all_user_routines/get_all_user_routines_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_all_user_routines/get_all_user_routines_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/get/get_user_by_email/get_user_by_email_response.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/presentation/screens/home/profile/routine_details_screen.dart';
import 'package:routines_gym_app/presentation/widgets/bottom_sheets/profile_settings/profile_settings_bottom_sheet.dart';
import 'package:routines_gym_app/provider/provider.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';
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

class _RoutinesListView extends StatefulWidget {
  const _RoutinesListView({required this.routinesFuture});

  final Future<List<RoutineDTO>> routinesFuture;

  @override
  State<_RoutinesListView> createState() => _RoutinesListViewState();
}

class _RoutinesListViewState extends State<_RoutinesListView> {
  late Future<List<RoutineDTO>> _routinesFuture;

  @override
  void initState() {
    super.initState();
    _routinesFuture = widget.routinesFuture;
  }

  Future<void> _deleteRoutine(String routineName) async {
    final RoutineProvider routineProvider = RoutineProvider();
    DeleteRoutineRequest deleteRoutineRequest = DeleteRoutineRequest(
      routineName: routineName,
    );
    DeleteRoutineResponse deleteRoutineResponse =
        await routineProvider.deleteRoutine(deleteRoutineRequest);

    if (deleteRoutineResponse.isSuccess!) {
      setState(() {
        _routinesFuture = widget.routinesFuture.then((routines) =>
            routines.where((r) => r.routineName != routineName).toList());
      });
    }

    ToastMessage.showToast(deleteRoutineResponse.message!);
  }

  Future<String> _getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("userEmail") ?? "no-email";
  }

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
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.public, size: 60, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    "You haven't created any routines yet.",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: routines.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final routine = routines[index];
            return _RoutineCard(
              routine: routine,
              onDelete: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Delete Routine"),
                    content:
                        const Text("Are you sure you want to delete this routine?"),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text("Cancel")),
                      TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text("Delete", style: TextStyle(color: Colors.red))),
                    ],
                  ),
                );

                if (confirm == true) {
                  await _deleteRoutine(routine.routineName);
                }
              },
              getUserEmail: _getUserEmail,
            );
          },
        );
      },
    );
  }
}

class _UserDataSection extends StatefulWidget {
  @override
  State<_UserDataSection> createState() => _UserDataSectionState();
}

class _UserDataSectionState extends State<_UserDataSection> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadSavedImage(); 
  }

  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString("profile_image_path");
    if (savedPath != null && File(savedPath).existsSync()) {
      setState(() {
        _profileImage = File(savedPath);
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("profile_image_path", imageFile.path);

      setState(() {
        _profileImage = imageFile;
      });
    }
  }

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

        if (snapshot.hasError ||
            !snapshot.hasData ||
            !(snapshot.data?.isSuccess ?? false)) {
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
              GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          _profileImage != null ? FileImage(_profileImage!) : null,
                      child: _profileImage == null
                          ? const Icon(Icons.person,
                              size: 40, color: Colors.white)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
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
  final VoidCallback onDelete;
  final Future<String> Function() getUserEmail;

  const _RoutineCard({
    required this.routine,
    required this.onDelete,
    required this.getUserEmail,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
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
        child: Row(
          children: [
            Expanded(
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
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
      onTap: () async {
        final email = await getUserEmail();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoutineDetailScreen(
              routineName: routine.routineName,
              userEmail: email,
            ),
          ),
        );
      },
    );
  }
}