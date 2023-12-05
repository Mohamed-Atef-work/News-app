import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/components/appText.dart';
import 'package:news/core/cubit/controller.dart';
import 'package:news/screens/Home/controller/states.dart';

import '../../../core/components/article.dart';
import '../../Home/controller/controller.dart';

class OneCategoryScreen extends StatelessWidget {
  late final String categoryForSearch;
  late final String categoryTitle;

   OneCategoryScreen({super.key,
    required this.categoryForSearch,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeController()
        ..getArticles(
          category: categoryForSearch.toLowerCase(),
          country: AppController.get(context).userModel!.country,
        ),
      child: BlocConsumer<HomeController, HomeStates>(
        buildWhen: (previousState, currentState) {
          return currentState is GetArticlesSuccessState ||
              currentState is BookMarkState;
        },
        listener: (context, state) {
          // Clearing the map to use it again So that no conflict will happen
          if (state is GetArticlesLoadingState) {
            AppController.get(context).markedArticlesIdsAllCategories.clear();
          }
          //
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: DefaultText(
                text: categoryTitle,
                fontSize: 25,
              ),
            ),
            body: HomeController.get(context).articlesCategoryResponse != null
                ? ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => ArticleItem(
                      markedArticlesMap: AppController.get(context)
                          .markedArticlesIdsAllCategories,
                      index: index,
                      article: HomeController.get(context)
                          .articlesCategoryResponse!
                          .articles[index],
                      onArticlePressed: () {
                        HomeController.get(context).goReadTheArticle(
                          context: context,
                          url: HomeController.get(context)
                              .articlesCategoryResponse!
                              .articles[index]
                              .url
                              .toString(),
                        );
                      },
                      onBookMarkPressed: () {
                        HomeController.get(context).bookMark(
                          index: index,
                          list: HomeController.get(context).isBookedCategory,
                        );
                      },
                      bookIcon:
                          HomeController.get(context).isBookedCategory[index]
                              ? Icons.bookmark_added_sharp
                              : Icons.bookmark_add_sharp,
                      bookMarkColor:
                          HomeController.get(context).isBookedCategory[index]
                              ? Colors.deepOrange
                              : Colors.black,
                    ),
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.deepOrangeAccent,
                      endIndent: 30,
                      indent: 30,
                    ),
                    itemCount: HomeController.get(context)
                        .articlesCategoryResponse!
                        .articles
                        .length,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        },
      ),
    );
  }
}
