import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';

class FriendProfileScreen extends StatelessWidget {
  final UserDTO friend;

  const FriendProfileScreen({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(friend.username),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.person, size: 80),
            const SizedBox(height: 20),
            Text('Username: ${friend.username}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Friend Code: ${friend.friendCode}', style: const TextStyle(fontSize: 16)),
            // Puedes añadir más campos aquí si los tienes
          ],
        ),
      ),
    );
  }
}