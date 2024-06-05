import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/components/appText.dart';
import 'package:news/core/cubit/controller.dart';
import 'package:news/core/cubit/states.dart';
import 'package:news/core/styles/colors.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/screens/home_screens/drawer/view.dart';

import '../../core/components/article.dart';

class BookMarkedScreen extends StatelessWidget {
  const BookMarkedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: DefaultText(
            text: AppLocalizations.of(context)!.bookMark, fontSize: 25),
      ),
      body: BlocBuilder<AppController, AppStates>(
        builder: (context, state) {
          final controller = AppController.get(context);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            child: Container(
              padding: const EdgeInsets.only(top: 2),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: controller.bookMarkedArticles.isNotEmpty
                  ? ListView.separated(
                      itemCount: controller.bookMarkedArticles.length,
                      itemBuilder: (context, index) => ArticleItem(
                        article: controller.bookMarkedArticles[index],
                        onArticlePressed: () => controller.goReadTheArticle(
                            context: context,
                            url: controller.bookMarkedArticles[index].url!
                                .toString()),
                        onBookMarkPressed: () =>
                            controller.deleteFromBookMarked(
                          articleId: controller.bookMarkedArticlesIds[index],
                        ),
                        bookIcon: Icons.bookmark_added_sharp,
                        bookMarkColor: Colors.deepOrange,
                        // This map is not needed in this screen because we do not bookmark!!!!.
                        markedArticlesMap: const {},
                        index: index,
                      ),
                      separatorBuilder: (_, __) => const Divider(
                        color: Colors.deepOrangeAccent,
                        endIndent: 30,
                        indent: 30,
                      ),
                    )
                  : Center(
                      child: DefaultText(
                        fontSize: 20,
                        textColor: Colors.black,
                        text: AppLocalizations.of(context)!
                            .youHaveNoArticlesBookmarked,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
