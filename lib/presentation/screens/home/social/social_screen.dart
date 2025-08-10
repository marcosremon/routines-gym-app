import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/get_all_user_friends/get_all_user_friends_response.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/provider/friend/friend_provider.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorThemes[17],
      appBar: _appBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _SearchFriends(),
            const Divider(
              color: Color(0xFFD6CBB8),
              thickness: 1,
            ),
            const SizedBox(height: 20),
            FutureBuilder<GetAllUserFriendsResponse>(
              future: _fetchFriends(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                final friends = snapshot.data?.friends;
                return (friends != null && friends.isNotEmpty)
                    ? _FriendsFound(friends: friends)
                    : _FriendsNotFound();
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('Social'),
      titleTextStyle: TextStyle(
        color: colorThemes[10],
        fontSize: 27,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: colorThemes[17],
      elevation: 0,
    );
  }

  Future<GetAllUserFriendsResponse> _fetchFriends() async {
    final FriendProvider friendProvider = FriendProvider();

    await Future.delayed(const Duration(seconds: 1));
    return await friendProvider.getAllUserFriends();
  }
}

class _FriendsFound extends StatelessWidget {
  final List<UserDTO> friends;
  const _FriendsFound({required this.friends});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: friends.length,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.person),
        title: Text(friends[index].username),
      ),
    );
  }
}

class _FriendsNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 30, 5, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(height: 30),
          Icon(
            Icons.public,
            size: 60,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            "There have been no updates from the people you follow.",
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

class _SearchFriends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      decoration: BoxDecoration(
        color: colorThemes[17],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 8),
            child: Text(
              "Search",
              style: TextStyle(
                color: colorThemes[10],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.zero, 
                constraints: const BoxConstraints(), 
                onPressed: () {
                  // to_do abrir perfil
                },
                icon: Icon(Icons.account_circle, size: 50),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: colorThemes[9],
                    hintText: 'Search Friends...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: IconButton(
                        icon: Icon(Icons.person_add_alt_1_rounded, color: colorThemes[10]),
                        onPressed: () {
                          // to_do agregar amigo
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}