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
    "assets/images/basketball.jpg",
    "assets/images/entertainment.jpg",
    "assets/images/health.jpg",
    "assets/images/technology.jpg",
    "assets/images/science.jpg",
  ];

  CategoriesController({
    required this.context,
  });
}
