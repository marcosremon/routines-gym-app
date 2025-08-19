// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/update_user/update_user_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/update_user/update_user_response.dart';
import 'package:routines_gym_app/presentation/widgets/buttons/custom_button.dart';
import 'package:routines_gym_app/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:routines_gym_app/provider/user/user_provider.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/get/get_user_by_email/get_user_by_email_response.dart';

class EditProfileBottomSheet extends StatefulWidget {
  final GetUserByEmailResponse getUserByEmailResponse; 

  const EditProfileBottomSheet({super.key, required this.getUserByEmailResponse});

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  late TextEditingController usernameController;
  late TextEditingController surnameController;
  late TextEditingController emailController;
  late TextEditingController dniController;

  @override
  void initState() {
    super.initState();
    usernameController =
        TextEditingController(text: widget.getUserByEmailResponse.userDTO?.username ?? '');
    surnameController =
        TextEditingController(text: widget.getUserByEmailResponse.userDTO?.surname ?? '');
    emailController =
        TextEditingController(text: widget.getUserByEmailResponse.userDTO?.email ?? '');
    dniController =
        TextEditingController(text: widget.getUserByEmailResponse.userDTO?.dni ?? '');
  }

  @override
  void dispose() {
    usernameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    dniController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        top: 24.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.edit, color: Colors.blueAccent, size: 48),
          const SizedBox(height: 12),
          const Text(
            'Edit your profile',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          CustomTextField(
            controller: emailController,
            hintText: 'Email',
            icon: Icons.email,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: usernameController,
            hintText: 'First Name',
            icon: Icons.person,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: surnameController,
            hintText: 'Last Name',
            icon: Icons.people,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: dniController,
            hintText: 'DNI',
            icon: Icons.badge,
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Cancel',
                  isPrimary: false,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  text: 'Save',
                  onPressed: () async {
                    final UserProvider userProvider = UserProvider();
                    final updateUserRequest = UpdateUserRequest(
                      username: usernameController.text.trim(),
                      surname: surnameController.text.trim(),
                      dniToBeFound: dniController.text.trim(),
                      email: emailController.text.trim(),
                    );

                    final UpdateUserResponse updateUserResponse =
                        await userProvider.updateUser(updateUserRequest);

                    ToastMessage.showToast(updateUserResponse.message ?? '');
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}