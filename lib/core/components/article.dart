import 'package:flutter/material.dart';
import 'package:news/core/cubit/controller.dart';
import 'package:news/l10n/app_localizations.dart';

import '../models/articleModel.dart';
import 'appText.dart';

class ArticleItem extends StatelessWidget {
  // logic of BookMarking
  late Map<int, String>? markedArticlesMap;
  late final int index;
  //
  late Articles article;
  late Color bookMarkColor;
  late IconData bookIcon;
  late void Function() onArticlePressed;
  late void Function() onBookMarkPressed;

  ArticleItem({
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
    return Stack(
      alignment: AppLocalizations.of(context)!.localeName == "ar"
          ? Alignment.bottomLeft
          : Alignment.bottomRight,
      children: [
        TextButton.icon(
          onPressed: onArticlePressed,
          icon: Container(
            height: 130,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: article.urlToImage != null
                    ? NetworkImage(
                        article.urlToImage.toString(),
                      )
                    : Image.asset(
                        "assets/images/readingApaper.jpg",
                      ).image,
                fit: article.urlToImage != null ? BoxFit.cover : BoxFit.contain,
              ),
            ),
          ),
          label: SizedBox(
            height: 130,
            width: double.infinity,
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title ?? AppLocalizations.of(context)!.unknown,
                  maxLines: 3,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: AppLocalizations.of(context)!.localeName == "ar"
                      ? TextAlign.right
                      : TextAlign.left,
                  textDirection:
                      AppLocalizations.of(context)!.localeName == "ar"
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                ),
                const Spacer(),
                DefaultText(
                  text: article.author ?? AppLocalizations.of(context)!.unknown,
                  textAlign: TextAlign.center,
                  textColor: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                DefaultText(
                  text: article.publishedAt ??
                      AppLocalizations.of(context)!.unknown,
                  textColor: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
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
              /*AppController.get(context).upLoadBookMarkedArticle(
                markedArticlesMap: markedArticlesMap!,
                article: article,
                index: index,
              );*/
            } else {
              AppController.get(context).deleteFromBookMarked(
                articleId: markedArticlesMap![index]!,
              );
            }
          },
          icon: Icon(
            bookIcon,
            color: bookMarkColor,
          ),
        )
      ],
    );
  }
}

//Icons.bookmark_added_sharp
//: Icons.bookmark_add_sharp
