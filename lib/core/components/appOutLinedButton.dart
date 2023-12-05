import 'package:flutter/material.dart';
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

  AppOutlinedButton({
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
      onPressed: () {
        onPressed();
      },
      style: OutlinedButton.styleFrom(
        fixedSize: Size(width ?? double.maxFinite, height),
        backgroundColor: backgroundColor,
        /*shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),*/
        elevation: elevation,
      ),
      child: DefaultText(
        text: text,
        fontWeight: fontWeight,
        fontSize: fontSize,
        textColor: textColor ?? Colors.white,
      ),
    );
  }
}
