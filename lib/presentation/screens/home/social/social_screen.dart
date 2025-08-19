// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/entities/user_dto.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/add_new_user_friend/add_new_user_friend_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/add_new_user_friend/add_new_user_friend_response.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/friend/get_all_user_friends/get_all_user_friends_response.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/screens/home/social/friend_profile_screen.dart';
import 'package:routines_gym_app/provider/friend/friend_provider.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  late Future<GetAllUserFriendsResponse> _friendsFuture;

  @override
  void initState() {
    super.initState();
    _friendsFuture = _fetchFriends();
  }

  void _refreshFriends() {
    setState(() {
      _friendsFuture = _fetchFriends();
    });
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
            _SearchFriends(onFriendAdded: _refreshFriends),
            const Divider(
              color: Color(0xFFD6CBB8),
              thickness: 1,
            ),
            const SizedBox(height: 20),
            FutureBuilder<GetAllUserFriendsResponse>(
              future: _friendsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final List<UserDTO>? friends = snapshot.data?.friends;
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
      itemBuilder: (context, index) {
        final friend = friends[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: colorThemes[17], 
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD6CBB8), width: 1),
          ),
          child: ListTile(
            leading: const Icon(Icons.person, size: 30, color: Colors.black87),
            title: Text(
              friend.username,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            onTap: () =>  {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FriendProfileScreen(friend: friend),
                ),
              )
            }

          ),
        );
      },
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
  final VoidCallback onFriendAdded;
  _SearchFriends({Key? key, required this.onFriendAdded}) : super(key: key);

  final TextEditingController _controller = TextEditingController();
  final FriendProvider _friendProvider = FriendProvider();

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
              Icon(
                Icons.account_circle,
                size: 50,
                color: colorThemes[13],
              ),
              const SizedBox(width: 10),

              Expanded(
                child: TextField(
                  controller: _controller,
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
                        onPressed: () async {
                          AddNewUserFriendRequest addNewUserFriendRequest = AddNewUserFriendRequest(
                            friendCode: _controller.text.trim(),
                          );
                          AddNewUserFriendResponse addNewUserFriendResponse = await _friendProvider.addNewUserFriend(addNewUserFriendRequest);
                          ToastMessage.showToast(addNewUserFriendResponse.message!);

                          if (addNewUserFriendResponse.isSuccess!) {
                            onFriendAdded(); 
                          }
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