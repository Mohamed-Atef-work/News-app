import 'package:flutter/material.dart';
import 'package:news/core/styles/colors.dart';

import 'controller.dart';
import 'widgets/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoriesController controller = CategoriesController(context: context);

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: controller.categoriesTitles.length,
      itemBuilder: (context, index) => CategoryItem(
        categoryForSearch: controller.categoriesNamesForSearch[index],
        categoryForTitle: controller.categoriesTitles[index],
        image: controller.images[index],
      ),
      separatorBuilder: (_, __) => const Divider(
        color: secondaryColor,
        endIndent: 30,
        indent: 30,
      ),
    );
  }
}
