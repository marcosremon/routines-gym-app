// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_new_password/create_new_password_request.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/widgets/buttons/custom_button.dart';
import 'package:routines_gym_app/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:routines_gym_app/provider/user/user_provider.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class ResetPasswordBottomSheet extends StatelessWidget {
  const ResetPasswordBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final resetEmailController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock_reset, color: colorThemes[16], size: 48),
          const SizedBox(height: 12),
          Text(
            'Did you forget your password?',
            style: TextStyle(color: colorThemes[16], fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Enter your email and we will send you instructions to change your password.',
            style: TextStyle(fontSize: 14, color: colorThemes[16]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          CustomTextField(
            controller: resetEmailController,
            hintText: 'Email',
            icon: Icons.email,
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
                  text: 'Send',
                  onPressed: () async {
                    String email = resetEmailController.text.trim();
                    if (email.isEmpty) {
                      ToastMessage.showToast('Please enter your email address');
                      return;
                    }
                    CreateNewPasswordRequest createNewPasswordRequest = CreateNewPasswordRequest(
                      userEmail: email
                    );

                    await context.read<UserProvider>().resetPassword(createNewPasswordRequest);
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