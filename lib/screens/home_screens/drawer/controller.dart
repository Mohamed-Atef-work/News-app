import 'package:flutter/material.dart';

import 'package:news/l10n/app_localizations.dart';
import 'package:news/screens/bookMark/view.dart';
import 'package:news/screens/profile/view.dart';
import 'package:news/screens/Home/view.dart';

class AppDrawerController {
  late BuildContext context;

  AppDrawerController({required this.context});

  late final List<IconData> icons = [
    Icons.home,
    Icons.person,
    Icons.bookmark,
    //Icons.settings,
    Icons.logout,
  ];
  late List<String> titles = [
    AppLocalizations.of(context)!.home,
    AppLocalizations.of(context)!.profile,
    AppLocalizations.of(context)!.bookMark,
    //AppLocalizations.of(context)!.settings,
    AppLocalizations.of(context)!.logOut,
  ];

  late final List<Widget> screens = [
    HomeLayOutScreen(),
    ProfileScreen(),
    BookMarkedScreen(),
  ];
}
