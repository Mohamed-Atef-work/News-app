import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news/core/cubit/controller.dart';
import 'package:news/core/components/article.dart';
import 'package:news/screens/Home/controller/states.dart';
import 'package:news/screens/Home/controller/controller.dart';

class RegionScreen extends StatelessWidget {
  const RegionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeController, HomeStates>(
      listener: (context, state) {
        // Clearing the map to use it again So that no conflict will happen
        if (state is GetArticlesLoadingState) {
          AppController.get(context).markedArticlesIdsAllCategories.clear();
        }
      },
      builder: (context, state) {
        final controller = HomeController.get(context);
        return controller.regionArticles.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.regionArticles.length,
                itemBuilder: (context, index) => ArticleItem(
                  markedArticlesMap:
                      AppController.get(context).markedArticlesIdsGeneral,
                  index: index,
                  onArticlePressed: () {
                    controller.goReadTheArticle(
                      context: context,
                      url: controller
                          .regionArticles[index].url
                          .toString(),
                    );
                  },
                  article: controller.regionArticles[index],
                  onBookMarkPressed: () {
                    controller.bookMark(
                      index: index,
                      list: controller.isBookedRegion,
                    );
                  },
                  bookMarkColor: controller.isBookedRegion[index]
                      ? Colors.deepOrangeAccent
                      : Colors.black,
                  bookIcon: controller.isBookedRegion[index]
                      ? Icons.bookmark_added_sharp
                      : Icons.bookmark_add_sharp,
                ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
