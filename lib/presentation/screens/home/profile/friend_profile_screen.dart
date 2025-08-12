// ignore_for_file: deprecated_member_use, strict_top_level_inference

import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_all_user_routines/get_all_user_routines_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/get/get_user_profile_detials/get_user_profile_details_response.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';

class FriendProfileScreen extends StatefulWidget {
  final UserDTO friend;

  const FriendProfileScreen({super.key, required this.friend});

  @override
  State<FriendProfileScreen> createState() => _FriendProfileScreenState();
}

class _FriendProfileScreenState extends State<FriendProfileScreen> {
  bool isLoading = true;
  late GetUserProfileDetilesResponse friendDetails;
  late Future<GetAllUserRoutinesResponse> _routinesFuture;

  @override
  void initState() {
    super.initState();
    _fetchFriendDetails();
    _routinesFuture = _fetchFriendRoutines();
  }

  Future<void> _fetchFriendDetails() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      friendDetails = GetUserProfileDetilesResponse(
        friendCode: widget.friend.friendCode,
        inscriptionDate: DateTime(2023, 6, 15),
        routineCount: 7,
      );
      isLoading = false;
    });
  }

  Future<GetAllUserRoutinesResponse> _fetchFriendRoutines() async {
    await Future.delayed(const Duration(seconds: 2));

    // to_do: call provider to get friend's routines

    return GetAllUserRoutinesResponse(
      success: true,
      message: "OK",
      routines: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorThemes[17],
      appBar: _appBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _profileCard(friendDetails),
                  const SizedBox(height: 20),
                  Text(
                    'Shared Routines',
                    style: TextStyle(
                      color: colorThemes[10],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: FutureBuilder<GetAllUserRoutinesResponse>(
                      future: _routinesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        final routines = snapshot.data?.routines;

                        return (routines != null && routines.isNotEmpty)
                            ? _FriendRoutinesListView(routines: routines)
                            : const _FriendRoutinesNotFound();
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text("${widget.friend.username}'s Profile"),
      titleTextStyle: TextStyle(
        color: colorThemes[10],
        fontSize: 27,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: colorThemes[17],
      elevation: 0,
    );
  }

  Widget _profileCard(GetUserProfileDetilesResponse friend) {
    final String formattedDate =
        "${friend.inscriptionDate.day}/${friend.inscriptionDate.month}/${friend.inscriptionDate.year}";

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorThemes[17],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorThemes[10], width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow(
            icon: Icons.vpn_key,
            label: 'Friend Code',
            value: friend.friendCode,
          ),
          const SizedBox(height: 12),
          _infoRow(
            icon: Icons.calendar_today,
            label: 'Registered since',
            value: formattedDate,
          ),
          const SizedBox(height: 12),
          _infoRow(
            icon: Icons.fitness_center,
            label: 'Created routines',
            value: '${friend.routineCount}',
          ),
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Icon(icon, color: Colors.grey.shade400, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'RobotoMono',
                  ),
                ),
                TextSpan(
                  text: " $value", // espacio aproposito
                  style: TextStyle(
                    color: colorThemes[10], 
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'RobotoMono',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FriendRoutinesListView extends StatelessWidget {
  final List<RoutineDTO> routines;

  const _FriendRoutinesListView({required this.routines});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: routines.length,
      itemBuilder: (context, index) {
        final routine = routines[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorThemes[10],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.fitness_center, color: colorThemes[0], size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  routine.routineName,
                  style: TextStyle(
                    color: colorThemes[0],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FriendRoutinesNotFound extends StatelessWidget {
  const _FriendRoutinesNotFound();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const FractionalOffset(0.5, 0.35), 
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.public, size: 60, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            "This friend hasn't shared any routines yet.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}