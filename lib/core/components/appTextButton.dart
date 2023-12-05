import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;

  AppTextButton({
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
