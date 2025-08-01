import 'package:flutter/material.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/screens/create_account_screen.dart';
import 'package:routines_gym_app/presentation/screens/login_screen.dart';
import 'package:routines_gym_app/presentation/widgets/buttons/primary_button.dart';
import 'package:routines_gym_app/presentation/widgets/decoration_background_circles/top_right_circle.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: colorThemes[15], // grey 100
      body: Center(
        child: Stack(
          children: [
            const TopRightCircle(),            
            Center(
              child: SizedBox(
                width: 350,
                height: 800,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 115, bottom: 0),
                        child: Text(
                          'Welcome!',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: colorThemes[10], // black
                          ),
                        ),
                      ),

                      Column(                        
                        children: [
                          PrimaryButton(
                            text: 'Get Started',
                            onPressed: () {
                               Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          TextButton( 
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                              );
                            },
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(color: colorThemes[13]), // grey
                                children: [
                                  TextSpan(
                                    text: 'Sign in',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}