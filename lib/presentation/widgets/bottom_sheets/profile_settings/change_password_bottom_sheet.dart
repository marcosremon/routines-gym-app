// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/change_password_with_password_and_email/change_password_with_password_and_email_reqeust.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/change_password_with_password_and_email/change_password_with_password_and_email_response.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/widgets/buttons/custom_button.dart';
import 'package:routines_gym_app/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:routines_gym_app/provider/user/user_provider.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class ChangePasswordBottomSheet extends StatelessWidget {
  const ChangePasswordBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock, color: colorThemes[16], size: 48),
          const SizedBox(height: 12),
          Text(
            'Change your password',
            style: TextStyle(
                color: colorThemes[16],
                fontWeight: FontWeight.bold,
                fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          CustomTextField(
            controller: oldPasswordController,
            hintText: 'Current Password',
            icon: Icons.lock_outline,
            obscureText: true,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: newPasswordController,
            hintText: 'New Password',
            icon: Icons.lock_reset,
            obscureText: true,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: confirmPasswordController,
            hintText: 'Confirm New Password',
            icon: Icons.lock_person,
            obscureText: true,
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
                    final oldPass = oldPasswordController.text.trim();
                    final newPass = newPasswordController.text.trim();
                    final confirmPass = confirmPasswordController.text.trim();

                    if (oldPass.isEmpty ||
                        newPass.isEmpty ||
                        confirmPass.isEmpty) {
                      ToastMessage.showToast(
                          'Please fill in all password fields');
                      return;
                    }

                    if (newPass != confirmPass) {
                      ToastMessage.showToast(
                          'New password and confirmation do not match');
                      return;
                    }

                    final UserProvider userProvider = UserProvider();
                    final ChangePasswordWithPasswordAndEmailRequest changePasswordRequest = ChangePasswordWithPasswordAndEmailRequest(
                      oldPassword: oldPass,
                      newPassword: newPass,
                      confirmNewPassword: confirmPass
                    );

                    ChangePasswordWithPasswordAndEmailResponse changePasswordResponse = await userProvider.changePassword(changePasswordRequest);
                    ToastMessage.showToast(changePasswordResponse.message!);
                    
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
