import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routines_gym_app/presentation/screens/login_screen.dart';
import 'package:routines_gym_app/presentation/widgets/buttons/primary_button.dart';
import 'package:routines_gym_app/presentation/widgets/login_circles/bottom_left_circle.dart';
import 'package:routines_gym_app/presentation/widgets/login_circles/top_right_circle.dart';
import 'package:routines_gym_app/presentation/widgets/text_fields/custom_password_field.dart';
import 'package:routines_gym_app/presentation/widgets/text_fields/custom_text_field.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Colors.white,
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
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),

                            _TextFields(),

                            PrimaryButton(
                              text: 'Sing Up',
                              onPressed: () {
                                // to_do ir al login tras logina
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hintText: 'DNI',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),
        
        CustomTextField(
          hintText: 'Username',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),
        
        CustomTextField(
          hintText: 'Email',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),
    
        CustomPasswordField(
          hintText: 'Password',
        ),
        const SizedBox(height: 12),
    
        CustomPasswordField(
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
              color: Colors.grey[600],
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