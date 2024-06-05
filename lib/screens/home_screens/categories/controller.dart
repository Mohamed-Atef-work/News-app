import 'package:flutter/cupertino.dart';
import 'package:news/l10n/app_localizations.dart';

class CategoriesController {
  late BuildContext context;
  late List<String> categoriesNamesForSearch = [
    "sport",
    "entertainment",
    "health",
    "technology",
    "science",
  ];
  late List<String> categoriesTitles = [
    AppLocalizations.of(context)!.sport,
    AppLocalizations.of(context)!.entertainment,
    AppLocalizations.of(context)!.health,
    AppLocalizations.of(context)!.technology,
    AppLocalizations.of(context)!.science,
  ];
  late List<String> images = [
    "assets/images/sport.jpeg",
    "assets/images/entertainment.jpeg",
    "assets/images/health.jpeg",
    "assets/images/technology.jpeg",
    "assets/images/science.jpeg",
  ];

  CategoriesController({required this.context});
}
