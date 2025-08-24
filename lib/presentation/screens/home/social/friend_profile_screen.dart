// ignore_for_file: deprecated_member_use, strict_top_level_inference

import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/routine_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_all_user_routines/get_all_user_routines_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_all_user_routines/get_all_user_routines_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/get/get_user_profile_detials/get_user_profile_details_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/get/get_user_profile_detials/get_user_profile_details_response.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/widgets/list_views/routines_list_views/routine_list_view.dart';
import 'package:routines_gym_app/provider/provider.dart';

class FriendProfileScreen extends StatefulWidget {
  final UserDTO friend;

  const FriendProfileScreen({super.key, required this.friend});

  @override
  State<FriendProfileScreen> createState() => _FriendProfileScreenState();
}

class _FriendProfileScreenState extends State<FriendProfileScreen> {
  bool isLoading = true;
  GetUserProfileDetilesResponse? friendDetails;
  late Future<GetAllUserRoutinesResponse> _routinesFuture;

  @override
  void initState() {
    super.initState();
    _fetchFriendDetails(widget.friend);
    _routinesFuture = _fetchFriendRoutines();
  }

  Future<void> _fetchFriendDetails(UserDTO friend) async {
    final UserProvider userProvider = UserProvider();

    GetUserProfileDetilesRequest getUserProfileDetilesRequest = GetUserProfileDetilesRequest(
      userEmail: friend.email,
    );
    
    final GetUserProfileDetilesResponse getUserProfileDetilesResponse = await userProvider.getUserProfileDetails(getUserProfileDetilesRequest);

    setState(() {
      friendDetails = getUserProfileDetilesResponse;
      isLoading = false;
    });
  }

  Future<GetAllUserRoutinesResponse> _fetchFriendRoutines() async {
    final RoutineProvider routineProvider = RoutineProvider();
    await Future.delayed(const Duration(seconds: 2));

    GetAllUserRoutinesRequest getAllUserRoutinesRequest = GetAllUserRoutinesRequest(
      userEmail: widget.friend.email,
    );
    return await routineProvider.getAllUserRoutines(getAllUserRoutinesRequest);
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
                  _profileCard(),
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

                        final List<RoutineDTO>? routines = snapshot.data?.routines;
                        return (routines != null && routines.isNotEmpty)
                            ? RoutinesListView(routines: routines)
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
      title: const Text("Friend Profile"),
      titleTextStyle: TextStyle(
        color: colorThemes[10],
        fontSize: 27,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: colorThemes[17],
      elevation: 0,
    );
  }

  Widget _profileCard() {
    if (friendDetails == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorThemes[17],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorThemes[10], width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow(
            icon: Icons.vpn_key_rounded,
            label: 'Username',
            value: friendDetails!.username ?? 'Unknown',
          ),
          const SizedBox(height: 14),
          _infoRow(
            icon: Icons.calendar_month_rounded,
            label: 'Registered since',
            value: friendDetails!.inscriptionDate != null
                ? '${friendDetails!.inscriptionDate!.day}/${friendDetails!.inscriptionDate!.month}/${friendDetails!.inscriptionDate!.year}'
                : 'Unknown',),
          const SizedBox(height: 14),
          _infoRow(
            icon: Icons.fitness_center_rounded,
            label: 'Created routines',
            value: '${friendDetails!.routineCount}',
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: colorThemes[10],
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$label:  ',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'RobotoMono',
                  ),
                ),
                TextSpan(
                  text: value,
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