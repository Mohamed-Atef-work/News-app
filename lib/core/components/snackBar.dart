import 'package:flutter/material.dart';

import 'appText.dart';

class AppSnackBar extends StatelessWidget {
  late String message;

  AppSnackBar({super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      backgroundColor: Colors.deepOrange,
      content: DefaultText(
        text: message,
        textAlign: TextAlign.center,
      ),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

  }
}
