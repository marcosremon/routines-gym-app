// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/delete_user/delete_user_response.dart';
import 'package:routines_gym_app/presentation/screens/login/login_screen.dart';
import 'package:routines_gym_app/presentation/widgets/bottom_sheets/show_my_friend_code_bottom_sheet.dart';
import 'package:routines_gym_app/presentation/widgets/pop-up/delete_account_pop_up.dart';
import 'package:routines_gym_app/provider/auth/auth_provider.dart';
import 'package:routines_gym_app/provider/provider.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingsBottomSheet extends StatelessWidget {
  final void Function(String value)? onSelected;

  const ProfileSettingsBottomSheet({super.key, this.onSelected});

  Future<bool> _isAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role') == 'admin';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isAdmin(),
      builder: (context, snapshot) {
        final isAdmin = snapshot.data ?? false;

        return SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOption(context, 'My friend code', Icons.qr_code, 'friendCode'),
                _buildOption(context, 'Edit account', Icons.edit, 'edit'),
                _buildOption(context, 'Change password', Icons.lock, 'changePassword'),
                _buildOption(context, 'Delete account', Icons.delete, 'delete'),
                _buildOption(context, 'Logout', Icons.logout, 'logout'),
                if (isAdmin)
                  _buildOption(context, 'Only admin option', Icons.admin_panel_settings, 'admin'),
              ],
            ),
          ),
        );
      },
    );
  }

Widget _buildOption(BuildContext context, String text, IconData icon, String value) {
  return ListTile(
    leading: Icon(icon, color: Colors.black),
    title: Text(
      text,
      style: const TextStyle(color: Colors.black),
    ),
    onTap: () async {
      Navigator.pop(context);

      switch (value) {
        case 'friendCode':
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const FriendCodeBottomSheet(),
          );
          break;
        case 'edit':
          debugPrint('Ir a pantalla de edición');
          break;
        case 'changePassword':
          debugPrint('Abrir formulario de cambio de contraseña');
          break;
        case 'delete':
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => DeleteAccountDialog(
              onConfirm: () async {
                final UserProvider userProvider = UserProvider();
                DeleteUserResponse deleteUserResponse =await userProvider.deleteAccount();
                if (deleteUserResponse.isSuccess!) {
                  final AuthProvider authProvider = AuthProvider();
                  await authProvider.logout();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                }
                ToastMessage.showToast(deleteUserResponse.message!);
              },
            ),
          );
          break;
        case 'logout':
          final AuthProvider authProvider = AuthProvider();
          await authProvider.logout();
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => const LoginScreen())
          );
          break;
        case 'admin':
          debugPrint('Acción exclusiva de admin');
          break;
      }

      // Si aún querés usar onSelected externo opcional
      if (onSelected != null) {
        onSelected!(value);
      }
    },
  );
}

}