import 'package:flutter/material.dart';
import 'package:news/core/components/appText.dart';
import 'package:news/core/components/navigator.dart';
import 'package:news/core/styles/colors.dart';
import 'package:news/screens/home_screens/oneCategoryArticles/view.dart';

class CategoryItem extends StatelessWidget {
  final String image;
  final String categoryForTitle;
  final String categoryForSearch;

  const CategoryItem({
    super.key,
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
          const SizedBox(width: 10),
          DefaultText(
            text: categoryForTitle,
            textColor: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios,color: Colors.black,),
        ],
      ),
    );
  }
}
