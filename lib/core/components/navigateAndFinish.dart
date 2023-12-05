import 'package:flutter/material.dart';

void navigateAndFinish({
  required context,
  required widget,
}) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        (Route<dynamic> route) => false);
