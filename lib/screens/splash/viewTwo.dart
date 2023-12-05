import 'dart:async';
import 'package:flutter/material.dart';

import '../../core/components/navigateAndFinish.dart';
import '../onBoarding/view.dart';

class SplashScreenThenOnBoarding extends StatefulWidget {
  const SplashScreenThenOnBoarding({Key? key}) : super(key: key);

  @override
  _SplashScreenThenOnBoardingState createState() =>
      _SplashScreenThenOnBoardingState();
}

class _SplashScreenThenOnBoardingState
    extends State<SplashScreenThenOnBoarding> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(
          seconds: 3,
        ), () {
      navigateAndFinish(
        context: context,
        widget: const OnBoardingScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: ,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/readingApaper.jpg',
              height: 200,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}
