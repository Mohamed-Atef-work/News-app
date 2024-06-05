import 'package:flutter/material.dart';
import 'package:news/core/cubit/controller.dart';
import 'package:news/core/styles/colors.dart';
import 'package:news/l10n/app_localizations.dart';

import '../models/articleModel.dart';
import 'appText.dart';

class ArticleItem extends StatelessWidget {
  // logic of BookMarking
  Map<int, String>? markedArticlesMap;
  final int index;
  //
  Articles article;
  Color bookMarkColor;
  IconData bookIcon;
  void Function() onArticlePressed;
  void Function() onBookMarkPressed;

  ArticleItem({
    super.key,
    // logic of BookMarking
    required this.markedArticlesMap,
    required this.index,
    //
    required this.article,
    required this.bookIcon,
    required this.bookMarkColor,
    required this.onArticlePressed,
    required this.onBookMarkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: Container(
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(20)),
        child: Stack(
          alignment: AppLocalizations.of(context)!.localeName == "ar"
              ? Alignment.bottomLeft
              : Alignment.bottomRight,
          children: [
            TextButton.icon(
              onPressed: onArticlePressed,
              icon: SizedBox(
                height: 130,
                width: 120,
                child: article.urlToImage != null
                    ? Image.network(article.urlToImage.toString(),
                        fit: BoxFit.cover)
                    : Image.asset("assets/images/logo.jpeg",
                        fit: BoxFit.contain),
              ),
              label: SizedBox(
                height: 130,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title ?? AppLocalizations.of(context)!.unknown,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign:
                          AppLocalizations.of(context)!.localeName == "ar"
                              ? TextAlign.right
                              : TextAlign.left,
                      textDirection:
                          AppLocalizations.of(context)!.localeName == "ar"
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                    ),
                    const Spacer(),
                    DefaultText(
                      text: article.author ??
                          AppLocalizations.of(context)!.unknown,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600,
                      textColor: Colors.black,
                      fontSize: 10,
                    ),
                    DefaultText(
                      text: article.publishedAt ??
                          AppLocalizations.of(context)!.unknown,
                      fontWeight: FontWeight.w600,
                      textColor: Colors.black,
                      fontSize: 10,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                onBookMarkPressed();
                if (bookIcon == Icons.bookmark_add_sharp) {
                  AppController.get(context).ensureArticleExistsThenUpLoadOrNot(
                    index: index,
                    article: article,
                    markedArticlesMap: markedArticlesMap!,
                  );
                } else {
                  AppController.get(context).deleteFromBookMarked(
                    articleId: markedArticlesMap![index]!,
                  );
                }
              },
              icon: Icon(bookIcon, color: bookMarkColor),
            )
          ],
        ),
      ),
    );
  }
}

//Icons.bookmark_added_sharp
//: Icons.bookmark_add_sharp
