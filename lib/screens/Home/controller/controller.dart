import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/components/navigator.dart';
import 'package:news/core/components/webView.dart';
import 'package:news/core/models/articleModel.dart';
import 'package:news/core/dataBase/remote/dio_helper.dart';
import 'package:news/core/dataBase/remote/end_points.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/screens/Home/controller/states.dart';
import 'package:news/screens/HomeScreens/business/view.dart';
import 'package:news/screens/HomeScreens/categories/view.dart';
import 'package:news/screens/HomeScreens/regionNews/view.dart';
import 'package:news/screens/HomeScreens/search/view.dart';

import '../../../core/dataBase/local/constants.dart';
import '../../register/model.dart';

class HomeController extends Cubit<HomeStates> {
  HomeController() : super(HomeInitialState());

  static HomeController get(context) => BlocProvider.of(context);

  late final TextEditingController searchController = TextEditingController();
  late final GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();

  late FirebaseFirestore fireStore = FirebaseFirestore.instance;

  int currentIndex = 0;
/*  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(IconlyBold.location),
      label: "Region",
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconlyBold.work),
      label: "Business",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.category_rounded),
      label: "Categories",
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconlyLight.search),
      label: "Search",
    ),
  ];*/

  /*String getLabel({
    required int index,
    required BuildContext context,
  }) {
    String label = "";
    switch (index) {
      case 0:
        {
          AppLocalizations.of(context)!.general;
          break;
        }
      case 1:
        {
          AppLocalizations.of(context)!.business;

          break;
        }
      case 2:
        {
          AppLocalizations.of(context)!.categories;

          break;
        }
      case 3:
        {
          AppLocalizations.of(context)!.search;
          break;
        }
    }
    return label;
  }*/

  List<Widget> screens = [
    RegionScreen(),
    BusinessScreen(),
    CategoriesScreen(),
    SearchScreen(),
  ];

  String getTitle({
    required int index,
    required BuildContext context,
  }) {
    String title = "t";
    switch (index) {
      case 0:
        {
          title = AppLocalizations.of(context)!.general;
          break;
        }
      case 1:
        {
          title = AppLocalizations.of(context)!.business;
          break;
        }
      case 2:
        {
          title = AppLocalizations.of(context)!.categories;
          break;
        }
      case 3:
        {
          title = AppLocalizations.of(context)!.search;

          break;
        }
    }
    return title;
  }

  void bookMark({
    required int index,
    required List<bool> list,
  }) {
    list[index] = !list[index];
    emit(BookMarkState());
  }

  void changeBottomAppBar(int index) {
    currentIndex = index;

    switch (index) {
      case 0:
        {
          emit(RegionChangeBottomNavState());
        }
        break;
      case 1:
        {
          emit(BusinessChangeBottomNavState());
          if (articlesBusinessResponse == null) {
            getArticles(
              category: "business",
              country: country,
            );
          }
        }
        break;

      case 2:
        {
          emit(AllCategoriesChangeBottomNavState());
        }
        break;

      case 3:
        {
          emit(SearchChangeBottomNavState());
        }
        break;
    }
  }

  void goReadTheArticle({
    //required int index,
    required BuildContext context,
    required String url,
  }) {
    navigateTo(
        context: context,
        widget: WebViewScreen(
          url: url,
        ));
  }

  // Rejoin

  ArticlesResponse? articlesRegionResponse;
  late List<bool> isBookedRegion;

  ArticlesResponse? articlesBusinessResponse;
  late List<bool> isBookedBusiness;

  ArticlesResponse? articlesCategoryResponse;
  late List<bool> isBookedCategory;

  ArticlesResponse? articlesSearchResponse;
  late List<bool> isBookedSearch;

  void getArticles({
    required String category,
    String? country,
    String? url,
    String? keyWord,
  }) {
    emit(GetArticlesLoadingState());
    DioHelper.getData(
      url: url ?? TOPHEADLINES,
      query: {
        if (category != "search") "country": country ?? "eg",
        if (category != "search") "category": category,
        if (category == "search") "q": keyWord,
        "apiKey": "40e8e5accae049fda753f567995efc4a",
      },
    ).then((value) {
      switch (category) {
        case "business":
          {
            articlesBusinessResponse = ArticlesResponse.fromJson(value.data);
            isBookedBusiness = List.generate(
                articlesBusinessResponse!.totalResults, (index) => false);
            emit(GetArticlesSuccessState());
          }
          break;

        case "general":
          {
            articlesRegionResponse = ArticlesResponse.fromJson(value.data);
            isBookedRegion = List.generate(
                articlesRegionResponse!.totalResults, (index) => false);
            emit(GetArticlesSuccessState());
          }
          break;

        case "search":
          {
            articlesSearchResponse = ArticlesResponse.fromJson(value.data);
            isBookedSearch = List.generate(
                articlesSearchResponse!.totalResults, (index) => false);

            if (articlesSearchResponse!.totalResults == 0) {}

            emit(GetArticlesSuccessState());
          }
          break;

        default:
          {
            articlesCategoryResponse = ArticlesResponse.fromJson(value.data);
            isBookedCategory = List.generate(
                articlesCategoryResponse!.totalResults, (index) => false);
            emit(GetArticlesSuccessState());
          }
          break;
      }
    }).catchError((error) {
      print(
          "get region articles Error is -----------------> ${error.toString()}");
      emit(GetArticlesErrorState());
    });
  }

  UserModel? userModel;

  void getUser() {
    emit(GetUserLoadingState());

    // get user
    fireStore.collection("users").doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print("The error is --------------->${error.toString()}");
      emit(GetUserErrorState());
    });
  }
}
