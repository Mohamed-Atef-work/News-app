import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class OnBoardingController {
  int currentIndex = 0;

  /*List<Widget> onBoardingScreens = [
    //OnBoardingOne(),
    //OnBoardingTwo(),
    OnBoardingThree(),
  ];*/

  List<String> images = [
    "assets/images/paperTwo.jpg",
    "assets/images/paperThree.jpg",
    "assets/images/readingApaper.jpg",
  ];

/*  List<String> texts = [
    "Welcome to travita, we help you to learn about the tourist places in the country you are visiting.",
    "Based on your interests, we help you build a complete travel plan that fits your financial budget",
    "Based on your interests, we help you build a complete travel plan that fits your financial budget",
  ];*/

  String getTitle({
    required int index,
    required BuildContext context,
  }) {
    String title = AppLocalizations.of(context)!.onBoardingThree;
    switch (index) {
      case 0:
        {
          title = AppLocalizations.of(context)!.onBoardingOne;
          break;
        }
      case 1:
        {
          title = AppLocalizations.of(context)!.onBoardingTwo;
          break;
        }
    }
    return title;
  }
}
