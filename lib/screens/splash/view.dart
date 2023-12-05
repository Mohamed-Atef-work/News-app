import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news/screens/Home/view.dart';

import '../../core/components/navigateAndFinish.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(
          seconds: 3,
        ), () {
      navigateAndFinish(
        context: context,
        widget: const HomeLayOutScreen(),
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
