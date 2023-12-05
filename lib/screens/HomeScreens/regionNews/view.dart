import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/components/article.dart';
import 'package:news/core/cubit/controller.dart';
import 'package:news/screens/Home/controller/controller.dart';

import 'package:news/screens/Home/controller/states.dart';

class RegionScreen extends StatelessWidget {
  const RegionScreen({Key? key}) : super(key: key);

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
        return HomeController.get(context).articlesRegionResponse != null
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => ArticleItem(
                  markedArticlesMap: AppController.get(context).markedArticlesIdsGeneral,
                  index: index,
                  onArticlePressed: () {
                    HomeController.get(context).goReadTheArticle(
                      //index: index,
                      context: context,
                      url: HomeController.get(context)
                          .articlesRegionResponse!
                          .articles[index]
                          .url
                          .toString(),
                    );
                  },
                  article: HomeController.get(context)
                      .articlesRegionResponse!
                      .articles[index],
                  onBookMarkPressed: () {
                    HomeController.get(context).bookMark(
                      index: index,
                      list: HomeController.get(context).isBookedRegion,
                    );
                  },
                  bookMarkColor:
                      HomeController.get(context).isBookedRegion[index]
                          ? Colors.deepOrange
                          : Colors.black,
                  bookIcon: HomeController.get(context).isBookedRegion[index]
                      ? Icons.bookmark_added_sharp
                      : Icons.bookmark_add_sharp,
                ),
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.deepOrangeAccent,
                  endIndent: 30,
                  indent: 30,
                ),
                itemCount: HomeController.get(context)
                    .articlesRegionResponse!
                    .articles
                    .length,
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
