import 'package:flutter/material.dart';
import 'appText.dart';

class CustomTextField extends StatelessWidget {
  final void Function(String)? onChanged;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String labelText;
  final GestureDetector? suffix;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final void Function(String?)? onSubmitted;

  CustomTextField({
    required this.labelText,
    this.onChanged,
    this.keyboardType,
    this.controller,
    this.obscureText,
    this.prefixIcon,
    this.suffix,
    this.validator,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      controller: controller,
      decoration: InputDecoration(
        label: DefaultText(
          text: labelText,
        ),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffix,
/*
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
*/
      ),
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      keyboardType: keyboardType,
    );
  }
}
