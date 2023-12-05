import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/components/appTextFormField.dart';
import 'package:news/core/cubit/controller.dart';
import 'package:news/core/dataBase/remote/end_points.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/screens/Home/controller/controller.dart';
import 'package:news/screens/Home/controller/states.dart';

import '../../../core/components/appText.dart';
import '../../../core/components/article.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeController, HomeStates>(
      listener: (context, state) {
        // Clearing the map to use it again So that no conflict will happen.
        if (state is GetArticlesLoadingState) {
          AppController.get(context).markedArticlesIdsAllCategories.clear();
        }
        //
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: HomeController.get(context).searchFormKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        labelText: AppLocalizations.of(context)!.search,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterWordToSearch;
                          }
                          return null;
                        },
                        onSubmitted: (value) {
                          if (HomeController.get(context)
                              .searchFormKey
                              .currentState!
                              .validate()) {
                            HomeController.get(context).getArticles(
                              url: EVERYTHING,
                              category: "search",
                              keyWord: HomeController.get(context)
                                  .searchController
                                  .text,
                            );
                            print(
                                "Data is ----------------->${HomeController.get(context).articlesSearchResponse!.totalResults}");
                          }
                        },
                        controller:
                            HomeController.get(context).searchController,
                      ),
                    ),
                    const CircleAvatar(
                      child: Icon(
                        Icons.send,
                      ),
                    ),
                  ],
                ),
                if (state is GetArticlesLoadingState)
                  const LinearProgressIndicator(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: HomeController.get(context).articlesSearchResponse ==
                            null
                        ? Center(
                            child: DefaultText(
                              text: AppLocalizations.of(context)!.results,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              textColor: Colors.grey.shade500,
                            ),
                          )
                        : HomeController.get(context)
                                    .articlesSearchResponse!
                                    .totalResults >
                                0
                            ? ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) => ArticleItem(
                                  markedArticlesMap: AppController.get(context)
                                      .markedArticlesIdsSearch,
                                  index: index,
                                  onArticlePressed: () {
                                    HomeController.get(context)
                                        .goReadTheArticle(
                                      //index: index,
                                      context: context,
                                      url: HomeController.get(context)
                                          .articlesSearchResponse!
                                          .articles[index]
                                          .url
                                          .toString(),
                                    );
                                  },
                                  article: HomeController.get(context)
                                      .articlesSearchResponse!
                                      .articles[index],
                                  onBookMarkPressed: () {
                                    HomeController.get(context).bookMark(
                                      index: index,
                                      list: HomeController.get(context)
                                          .isBookedSearch,
                                    );
                                  },
                                  bookMarkColor: HomeController.get(context)
                                          .isBookedSearch[index]
                                      ? Colors.deepOrange
                                      : Colors.black,
                                  bookIcon: HomeController.get(context)
                                          .isBookedSearch[index]
                                      ? Icons.bookmark_added_sharp
                                      : Icons.bookmark_add_sharp,
                                ),
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  color: Colors.deepOrangeAccent,
                                  endIndent: 30,
                                  indent: 30,
                                ),
                                itemCount: HomeController.get(context)
                                    .articlesSearchResponse!
                                    .articles
                                    .length,
                              )
                            : state is GetArticlesLoadingState
                                ? Center(
                                    child: DefaultText(
                                      text:
                                          AppLocalizations.of(context)!.loading,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      textColor: Colors.grey.shade500,
                                    ),
                                  )
                                : Center(
                                    child: DefaultText(
                                      text: AppLocalizations.of(context)!
                                          .noResults,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      textColor: Colors.grey.shade500,
                                    ),
                                  ), //No Results
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//Center(
//                                 child: DefaultText(
//                                   text: "Results...",
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   textColor: Colors.grey.shade500,
//                                 ),
//                               )

/*Widget searchWidget({
  required HomeStates state,
  required ArticlesResponse? response,
  required BuildContext context,
}) {
  if (state is GetArticlesSuccessState && response != null && response.totalResults ) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => ArticleItem(
        onArticlePressed: () {
          HomeController.get(context).goReadTheArticle(
            //index: index,
            context: context,
            url: response.articles[index].url.toString(),
          );
        },
        article: response.articles[index],
        onBookMarkPressed: () {
          HomeController.get(context).bookMark(
            index: index,
            list: HomeController.get(context).isBookedSearch,
          );
        },
        bookMarkColor: HomeController.get(context).isBookedSearch[index]
            ? Colors.deepOrange
            : Colors.black,
        bookIcon: HomeController.get(context).isBookedSearch[index]
            ? Icons.bookmark_added_sharp
            : Icons.bookmark_add_sharp,
      ),
      separatorBuilder: (context, index) => const Divider(
        color: Colors.deepOrangeAccent,
        endIndent: 30,
        indent: 30,
      ),
      itemCount: response.articles.length,
    );
  } else if (state is GetArticlesSuccessState && response) {
    return;
  } else if (state is SearchChangeBottomNavState ||
      state is GetArticlesErrorState) {
    return Center(
      child: DefaultText(
        text: "Results...",
        fontSize: 20,
        fontWeight: FontWeight.bold,
        textColor: Colors.grey.shade500,
      ),
    );
  }
}*/
