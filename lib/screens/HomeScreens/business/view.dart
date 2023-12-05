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
    return BlocConsumer<HomeController, HomeStates>(
      /*buildWhen: (previousState, currentState) {
        return currentState == RegionGetArticlesSuccessState();
      },*/
      listener: (context, state) {
        // Clearing the map to use it again So that no conflict will happen
        if (state is GetArticlesLoadingState) {
          AppController.get(context).markedArticlesIdsAllCategories.clear();
        }
        //
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition:
              HomeController.get(context).articlesBusinessResponse != null,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => ArticleItem(
              markedArticlesMap:
                  AppController.get(context).markedArticlesIdsBusiness,
              index: index,
              article: HomeController.get(context)
                  .articlesBusinessResponse!
                  .articles[index],
              onArticlePressed: () {
                HomeController.get(context).goReadTheArticle(
                  //index: index,
                  context: context,
                  url: HomeController.get(context)
                      .articlesBusinessResponse!
                      .articles[index]
                      .url
                      .toString(),
                );
              },
              onBookMarkPressed: () {
                HomeController.get(context).bookMark(
                  index: index,
                  list: HomeController.get(context).isBookedBusiness,
                );
              },
              bookIcon: HomeController.get(context).isBookedBusiness[index]
                  ? Icons.bookmark_added_sharp
                  : Icons.bookmark_add_sharp,
              bookMarkColor: HomeController.get(context).isBookedBusiness[index]
                  ? Colors.deepOrange
                  : Colors.black,
            ),
            separatorBuilder: (context, index) => const Divider(
              color: Colors.deepOrangeAccent,
              endIndent: 30,
              indent: 30,
            ),
            itemCount: HomeController.get(context)
                .articlesBusinessResponse!
                .articles
                .length,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
