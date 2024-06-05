import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class OnBoardingController {
  int currentIndex = 0;

  List<String> images = [
    "assets/images/first.jpeg",
    "assets/images/second.jpeg",
    "assets/images/third.jpeg",
  ];

  String getTitle({
    required int index,
    required BuildContext context,
  }) {
    final local = AppLocalizations.of(context)!;
    String title = local.onBoardingThree;
    switch (index) {
      case 0:
        {
          title = local.onBoardingOne;
          break;
        }
      case 1:
        {
          title = local.onBoardingTwo;
          break;
        }
    }
    return title;
  }
}
