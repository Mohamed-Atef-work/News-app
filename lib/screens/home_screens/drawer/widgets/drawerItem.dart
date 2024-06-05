import 'package:flutter/material.dart';

import '../../../../core/components/appText.dart';

class DrawerItem extends StatelessWidget {
  late final String title;
  late final IconData icon;
  late void Function() onPressed;

  DrawerItem({super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 0,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              size: 35,
              color: Colors.deepOrange.shade500,
            ),
            const SizedBox(
              width: 20,
            ),
            DefaultText(
              text: title,
              textColor: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}
