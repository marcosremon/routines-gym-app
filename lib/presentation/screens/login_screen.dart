import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/screens/create_account_screen.dart';
import 'package:routines_gym_app/presentation/widgets/buttons/primary_button.dart';
import 'package:routines_gym_app/presentation/widgets/decoration_background_circles/bottom_left_circle.dart';
import 'package:routines_gym_app/presentation/widgets/decoration_background_circles/top_right_circle.dart';
import 'package:routines_gym_app/presentation/widgets/text_fields/custom_password_field.dart';
import 'package:routines_gym_app/presentation/widgets/text_fields/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: colorThemes[9], // white background
      body: Stack(
        children: [
          const TopRightCircle(),
          const BottomLeftCircle(),
          Center(
            child: SizedBox(
              width: 350,
              child: Column(
                children: [
                  const SizedBox(height: 125),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 100, 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Login',
                                    style: GoogleFonts.poppins(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: colorThemes[10], // black
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  Text(
                                    'Please sign in to continue.',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: colorThemes[11], // grey 600
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            CustomTextField(
                              hintText: 'Email',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController, 
                            ),
                            const SizedBox(height: 20),

                            CustomPasswordField(
                              hintText: 'Password',
                              controller: passwordController, 
                            ),
                            const SizedBox(height: 40),

                            PrimaryButton(
                              text: 'Login',
                              onPressed: () {
                                String email = emailController.text;
                                String password = passwordController.text;

                                // to_do: Implement login logic

                                print('Email: $email');
                                print('Password: $password'); 
                              },
                            ),
                            _DividerOrBar(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _SocialLoginButton(
                                  assetPath: 'assets/icons/google-icon.png',
                                  onPressed: () {
                                    // to_do ir al home con google
                                  },
                                ),
                                const SizedBox(width: 20),
                                _SocialLoginButton(
                                  assetPath: 'assets/icons/apple-icon.png',
                                  onPressed: () {
                                    // to_do ir al home con apple
                                  },
                                ),
                              ],
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

class _AlreadyHaveAccount extends StatelessWidget {
  final Color primaryColor;

  const _AlreadyHaveAccount({
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(75, 0, 0, 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "¿No tienes cuenta? ",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: colorThemes[11], // grey 600
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
              );
            },
            child: Text(
              "Regístrate",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DividerOrBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 25),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: colorThemes[12], // grey 400
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'OR',
              style: GoogleFonts.poppins(
                color: colorThemes[11], // grey 600
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: colorThemes[12], // grey 400
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onPressed;

  const _SocialLoginButton({
    required this.assetPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: colorThemes[9], // white
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: colorThemes[13].withOpacity(0.3), // grey 300
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(assetPath),
        ),
      ),
    );
  }
}