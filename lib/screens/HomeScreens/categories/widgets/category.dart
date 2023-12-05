import 'package:flutter/material.dart';
import 'package:news/core/components/appText.dart';
import 'package:news/core/components/navigator.dart';
import 'package:news/screens/HomeScreens/oneCategoryArticles/view.dart';

class CategoryItem extends StatelessWidget {
  late final String image;
  late final String categoryForTitle;
  late final String categoryForSearch;

  CategoryItem({
    required this.image,
    required this.categoryForTitle,
    required this.categoryForSearch,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        navigateTo(
          context: context,
          widget: OneCategoryScreen(
            categoryTitle: categoryForTitle,
            categoryForSearch: categoryForSearch,
          ),
        );
      },
      icon: CircleAvatar(
        foregroundImage: AssetImage(image),
        radius: 50,
      ),
      label: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          DefaultText(
            text: categoryForTitle,
            fontWeight: FontWeight.bold,
            textColor: Colors.black,
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
  }
}
