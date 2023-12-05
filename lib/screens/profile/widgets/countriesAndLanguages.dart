
import 'package:flutter/material.dart';

import '../../../core/components/appText.dart';

class OneCountryOrLanguage extends StatelessWidget {
  Function onTap;
  String countryOrLanguageName;
  Color countryOrLanguageColor;
  Color textColor;

  OneCountryOrLanguage({super.key,
    required this.onTap,
    required this.countryOrLanguageName,
    required this.countryOrLanguageColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: countryOrLanguageColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: DefaultText(
          text: countryOrLanguageName,
          textColor: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
