import 'package:flutter/material.dart';

import 'controller.dart';
import 'widgets/category.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoriesController controller = CategoriesController(
      context: context,
    );

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => CategoryItem(
        categoryForSearch: controller.categoriesNamesForSearch[index],
        categoryForTitle: controller.categoriesTitles[index],
        image: controller.images[index],
      ),
      separatorBuilder: (context, index) => const Divider(
        color: Colors.grey,
        endIndent: 30,
        indent: 30,
      ),
      itemCount: controller.categoriesTitles.length,
    );
  }
}
