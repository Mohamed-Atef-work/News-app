import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:news/l10n/app_localizations.dart';

import '../controller/controller.dart';

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(IconlyBold.location),
            label: AppLocalizations.of(context)!.general,
          ),
          BottomNavigationBarItem(
            icon: const Icon(IconlyBold.work),
            label: AppLocalizations.of(context)!.business,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.category_rounded),
            label: AppLocalizations.of(context)!.categories,
          ),
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.search),
            label: AppLocalizations.of(context)!.search,
          ),
        ],
        currentIndex: HomeController.get(context).currentIndex,
        onTap: (index) {
          HomeController.get(context).changeBottomAppBar(index);
        });
  }
}
