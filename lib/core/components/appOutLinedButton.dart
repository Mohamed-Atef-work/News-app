import 'package:flutter/material.dart';
import 'package:news/core/styles/colors.dart';
import 'appText.dart';

class AppOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final double? elevation;

  const AppOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.height,
    this.width,
    this.backgroundColor,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        fixedSize: Size(width ?? double.maxFinite, height),
        backgroundColor: backgroundColor,
        elevation: elevation,side: BorderSide(color: secondaryColor)
      ),
      child: DefaultText(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        textColor: textColor ?? Colors.white,
      ),
    );
  }
}
