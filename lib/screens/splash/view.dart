import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news/screens/Home/view.dart';

import '../../core/components/navigateAndFinish.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => navigateAndFinish(
        context: context,
        widget: const HomeLayOutScreen(),
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
