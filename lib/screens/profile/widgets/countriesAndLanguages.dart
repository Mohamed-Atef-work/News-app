import 'package:flutter/material.dart';

import '../../../core/components/appText.dart';

class OneCountryOrLanguage extends StatelessWidget {
  final Color textColor;
  final void Function()? onTap;
  final String countryOrLanguageName;
  final Color countryOrLanguageColor;

  const OneCountryOrLanguage({
    super.key,
    required this.onTap,
    required this.textColor,
    required this.countryOrLanguageName,
    required this.countryOrLanguageColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
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
          fontWeight: FontWeight.w300,
          text: countryOrLanguageName,
          textColor: textColor,
          fontSize: 20,
        ),
      ),
    );
  }
}
