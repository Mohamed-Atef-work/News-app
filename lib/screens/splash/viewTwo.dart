import 'dart:async';
import 'package:flutter/material.dart';

import '../../core/components/navigateAndFinish.dart';
import '../onBoarding/view.dart';

class SplashScreenThenOnBoarding extends StatefulWidget {
  const SplashScreenThenOnBoarding({super.key});

  @override
  State<SplashScreenThenOnBoarding> createState() =>
      _SplashScreenThenOnBoardingState();
}

class _SplashScreenThenOnBoardingState
    extends State<SplashScreenThenOnBoarding> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => navigateAndFinish(
        context: context,
        widget: const OnBoardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFfb7f01),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/logo.jpeg',
              height: 200,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}
