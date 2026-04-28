import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFADC4FF), // Light blue matching the Figma gradient
            ],
            stops: [0.4, 1.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your custom logo is now here!
            Image.asset(
              'lib/assets/images/DormBNBLogoLight.png',
              width: 90,
              height: 90,
            ),
            const SizedBox(height: 12),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800, // Extra bold
                  letterSpacing: 0.5,
                  fontFamily: 'Nunito',
                ),
                children: [
                  TextSpan(
                    text: 'Dorm',
                    style: TextStyle(color: Color(0xFF2C2C2C)), // Dark Gray
                  ),
                  TextSpan(
                    text: 'BNB',
                    style: TextStyle(color: Color(0xFF4A8BFE)), // Bright Blue

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

