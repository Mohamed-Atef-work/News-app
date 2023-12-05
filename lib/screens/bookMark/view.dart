import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/components/appText.dart';
import 'package:news/core/cubit/controller.dart';
import 'package:news/core/cubit/states.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/screens/HomeScreens/drawer/view.dart';

import '../../core/components/article.dart';

class BookMarkedScreen extends StatelessWidget {
  const BookMarkedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
          title: DefaultText(
        text: AppLocalizations.of(context)!.bookMark,
        fontSize: 25,
      )),
      body: BlocConsumer<AppController, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return AppController.get(context).bookMarkedArticles.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                    right: 8,
                    left: 8,
                    bottom: 1,
                  ),
                  child: Container(
                    //width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 2,
                    ),

                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListView.separated(
                      itemBuilder: (context, index) => ArticleItem(
                        article: AppController.get(context)
                            .bookMarkedArticles[index],
                        onArticlePressed: () {
                          AppController.get(context).goReadTheArticle(
                              //index: index,
                              context: context,
                              url: AppController.get(context)
                                  .bookMarkedArticles[index]
                                  .url!
                                  .toString());
                        },
                        onBookMarkPressed: () {
                          AppController.get(context).deleteFromBookMarked(
                            articleId: AppController.get(context)
                                .bookMarkedArticlesIds[index],
                          );
                        },
                        bookIcon: Icons.bookmark_added_sharp,
                        bookMarkColor: Colors.deepOrange,
                        // This map is not needed in this screen because we do not bookmark!!!!.
                        markedArticlesMap: const {},
                        index: index,
                      ),
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.deepOrangeAccent,
                        endIndent: 30,
                        indent: 30,
                      ),
                      itemCount:
                          AppController.get(context).bookMarkedArticles.length,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                    right: 8,
                    left: 8,
                    bottom: 1,
                  ),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: DefaultText(
                        text: AppLocalizations.of(context)!
                            .youHaveNoArticlesBookmarked,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.grey.shade500,
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
