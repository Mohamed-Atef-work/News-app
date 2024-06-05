import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/components/appTextFormField.dart';
import 'package:news/core/cubit/controller.dart';
import 'package:news/core/dataBase/remote/end_points.dart';
import 'package:news/core/styles/colors.dart';
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
        final controller = HomeController.get(context);

        controller.searchScrollController
            .addListener(controller.scrollListener);

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: controller.searchFormKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: controller.searchController,
                        labelText: AppLocalizations.of(context)!.search,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterWordToSearch;
                          }
                          return null;
                        },
                        onSubmitted: (value) {
                          if (controller.searchFormKey.currentState!
                              .validate()) {
                            controller.page = 1;
                            controller.isPaginationLoading = false;
                            controller.searchArticles = [];
                            controller.isBookedSearch = [];
                            controller.getArticles(
                              url: EVERYTHING,
                              category: "search",
                              keyWord: controller.searchController.text,
                            );
                            print(
                                "Data is ----------------->${controller.searchArticles}");
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: secondaryColor,
                      child: Icon(
                        color: primaryColor,
                        Icons.send,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                if (state is GetArticlesLoadingState) ...[
                  const SizedBox(height: 10),
                  const LinearProgressIndicator()
                ],
                const SizedBox(height: 10),
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: controller.searchArticles.isEmpty
                        ? Center(
                            child: DefaultText(
                              text: AppLocalizations.of(context)!.results,
                              fontWeight: FontWeight.bold,
                              textColor: Colors.black,
                              fontSize: 20,
                            ),
                          )
                        : controller.searchArticles.isNotEmpty
                            ? ListView.separated(
                                controller: controller.searchScrollController,
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.searchArticles.length,
                                itemBuilder: (context, index) => ArticleItem(
                                  markedArticlesMap: AppController.get(context)
                                      .markedArticlesIdsSearch,
                                  index: index,
                                  onArticlePressed: () =>
                                      controller.goReadTheArticle(
                                    context: context,
                                    url: controller.searchArticles[index].url
                                        .toString(),
                                  ),
                                  article: controller.searchArticles[index],
                                  onBookMarkPressed: () => controller.bookMark(
                                    index: index,
                                    list: controller.isBookedSearch,
                                  ),
                                  bookMarkColor:
                                      controller.isBookedSearch[index]
                                          ? Colors.deepOrange
                                          : Colors.black,
                                  bookIcon: controller.isBookedSearch[index]
                                      ? Icons.bookmark_added_sharp
                                      : Icons.bookmark_add_sharp,
                                ),
                                separatorBuilder: (_, __) => const Divider(
                                  color: Colors.deepOrangeAccent,
                                  endIndent: 30,
                                  indent: 30,
                                ),
                              )
                            : state is GetArticlesLoadingState
                                ? Center(
                                    child: DefaultText(
                                      text:
                                          AppLocalizations.of(context)!.loading,
                                      fontWeight: FontWeight.bold,
                                      textColor: Colors.black,
                                      fontSize: 20,
                                    ),
                                  )
                                : Center(
                                    child: DefaultText(
                                      text: AppLocalizations.of(context)!
                                          .noResults,
                                      fontWeight: FontWeight.bold,
                                      textColor: Colors.black,
                                      fontSize: 20,
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
