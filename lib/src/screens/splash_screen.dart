import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smartaccess_app/src/screens/login_screen.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: LayoutBuilder(
        builder: (context, constraints) {
          double splashSize =
              constraints.maxHeight * 0.6; // Adjust the size factor as needed
          return Center(
            child: LottieBuilder.asset(
              AppConstants.splashAnimation,
              height: splashSize,
              width: splashSize,
              fit: BoxFit.contain,
            ),
          );
        },
      ),
      nextScreen: LoginScreen(),
      splashIconSize: 450,
      backgroundColor: AppColor.night,
    );
  }
}
