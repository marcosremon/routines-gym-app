// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_user/create_user_request.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/user/create/create_user/create_user_response.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/screens/login_screen.dart';
import 'package:routines_gym_app/presentation/widgets/buttons/primary_button.dart';
import 'package:routines_gym_app/presentation/widgets/decoration_background_circles/bottom_left_circle.dart';
import 'package:routines_gym_app/presentation/widgets/decoration_background_circles/top_right_circle.dart';
import 'package:routines_gym_app/presentation/widgets/text_fields/custom_password_field.dart';
import 'package:routines_gym_app/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:routines_gym_app/provider/user/user_provider.dart';
import 'package:routines_gym_app/transversal/utils/toast_message.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = UserProvider();
    final TextEditingController dniController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: colorThemes[9], // white
      body: Stack(
        children: [

          const TopRightCircle(),
          const BottomLeftCircle(),
          
          Center(
            child: SizedBox(
              width: 390,
              child: Column(
                children: [
                  const SizedBox(height: 105),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create Account',
                                  style: GoogleFonts.poppins(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: colorThemes[10], // black
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),

                            _TextFields(
                              dniController: dniController,
                              usernameController: usernameController,
                              emailController: emailController,
                              passwordController: passwordController,
                              confirmPasswordController: confirmPasswordController,
                            ),
                            
                            PrimaryButton(
                              text: 'Sing Up',
                              onPressed: () async {
                                CreateUserRequest createUserRequest = CreateUserRequest(
                                  dni: dniController.text,
                                  username: usernameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword: confirmPasswordController.text,
                                );
                                
                                CreateUserResponse createUserResponse = await userProvider.createUser(createUserRequest);
                                ToastMessage.showToast(createUserResponse.message!);
                                if (createUserResponse.isSuccess) {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  _AlreadyHaveAccount(primaryColor: primaryColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextFields extends StatelessWidget {
  final TextEditingController dniController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const _TextFields({
    required this.dniController,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: dniController,
          hintText: 'DNI',
          icon: Icons.perm_identity,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: usernameController,
          hintText: 'Username',
          icon: Icons.person_outline,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: emailController,
          hintText: 'Email',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),
        CustomPasswordField(
          controller: passwordController,
          hintText: 'Password',
        ),
        const SizedBox(height: 12),
        CustomPasswordField(
          controller: confirmPasswordController,
          hintText: 'Confirm Password',
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}

class _AlreadyHaveAccount extends StatelessWidget {
  final Color primaryColor;

  const _AlreadyHaveAccount({
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Already have an account? ",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: colorThemes[11], // grey 600
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: Text(
              "Sign in",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 30),
        ],
      ),
    );
  }
}