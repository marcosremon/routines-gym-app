import 'package:flutter/material.dart'; 
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
                _buildOption(context, 'Mi código', Icons.qr_code, 'friendCode'),
                _buildOption(context, 'Editar cuenta', Icons.edit, 'edit'),
                _buildOption(context, 'Cambiar contraseña', Icons.lock, 'changePassword'),
                _buildOption(context, 'Borrar cuenta', Icons.delete, 'delete'),
                _buildOption(context, 'Cerrar sesión', Icons.logout, 'logout'),
                if (isAdmin)
                  _buildOption(context, 'Opción solo admin', Icons.admin_panel_settings, 'admin'),
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
      onTap: () {
        Navigator.pop(context); 
        if (onSelected != null) {
          onSelected!(value);
        }
      },
    );
  }
}