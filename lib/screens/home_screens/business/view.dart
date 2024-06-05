import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/components/article.dart';
import 'package:news/core/cubit/controller.dart';
import 'package:news/screens/Home/controller/controller.dart';
import 'package:news/screens/Home/controller/states.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.get(context);
    final appController = AppController.get(context);
    return BlocConsumer<HomeController, HomeStates>(
      listener: (context, state) {
        // Clearing the map to use it again So that no conflict will happen
        if (state is GetArticlesLoadingState) {
          appController.markedArticlesIdsAllCategories.clear();
        }
      },
      builder: (_, __) {
        return ConditionalBuilder(
          condition: homeController.businessArticles.isNotEmpty,
          builder: (context) => ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => ArticleItem(
              index: index,
              markedArticlesMap: appController.markedArticlesIdsBusiness,
              article: homeController.businessArticles[index],
              onArticlePressed: () => homeController.goReadTheArticle(
                context: context,
                url: homeController.businessArticles[index].url.toString(),
              ),
              onBookMarkPressed: () => homeController.bookMark(
                index: index,
                list: homeController.isBookedBusiness,
              ),
              bookIcon: homeController.isBookedBusiness[index]
                  ? Icons.bookmark_added_sharp
                  : Icons.bookmark_add_sharp,
              bookMarkColor: homeController.isBookedBusiness[index]
                  ? Colors.deepOrange
                  : Colors.black,
            ),
            itemCount: homeController.businessArticles.length,
          ),
          fallback: (_) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
