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
import 'package:news/screens/home_screens/business/view.dart';
import 'package:news/screens/home_screens/categories/view.dart';
import 'package:news/screens/home_screens/regionNews/view.dart';
import 'package:news/screens/home_screens/search/view.dart';

import '../../../core/dataBase/local/constants.dart';
import '../../register/model.dart';

class HomeController extends Cubit<HomeStates> {
  HomeController() : super(HomeInitialState());

  static HomeController get(context) => BlocProvider.of(context);

  final TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  int currentIndex = 0;

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
          page = 1;
          isPaginationLoading = false;
          isEndPagination = false;
          emit(RegionChangeBottomNavState());
        }
        break;
      case 1:
        {
          page = 1;
          isEndPagination = false;
          isPaginationLoading = false;
          emit(BusinessChangeBottomNavState());
          if (businessArticles.isEmpty) {
            getArticles(category: "business", country: country);
          }
        }
        break;

      case 2:
        {
          page = 1;
          isEndPagination = false;
          isPaginationLoading = false;
          emit(AllCategoriesChangeBottomNavState());
        }
        break;

      case 3:
        {
          page = 1;
          isEndPagination = false;
          isPaginationLoading = false;
          emit(SearchChangeBottomNavState());
        }
        break;
    }
  }

  void goReadTheArticle({
    required BuildContext context,
    required String url,
  }) {
    navigateTo(
      context: context,
      widget: WebViewScreen(url: url),
    );
  }

  // Rejoin

  List<Articles> regionArticles = [];
  late List<bool> isBookedRegion;

  List<Articles> businessArticles = [];
  late List<bool> isBookedBusiness;

  List<Articles> articlesOfCategory = [];
  late List<bool> isBookedCategory;

  List<Articles> searchArticles = [];
  late List<bool> isBookedSearch;

  final searchScrollController = ScrollController();
  void scrollListener() {
    final currentLength = searchScrollController.position.pixels;
    final maxLength = searchScrollController.position.maxScrollExtent;
    if (currentLength > maxLength * 0.85) {
      if (!isPaginationLoading && !isEndPagination) {
        isPaginationLoading = true;
        print("page ---------------------------------------------- > $page");
        print(" ---------------- in the method ---------------------------");
        getArticles(
          url: EVERYTHING,
          category: "search",
          keyWord: searchController.text,
        );
      }
    }
  }

  int page = 1;
  bool isEndPagination = false;
  bool isPaginationLoading = false;

  void getArticles({
    required String category,
    String? keyWord,
    String? country,
    String? url,
  }) async {
    try {
      emit(GetArticlesLoadingState());
      print("------------------Loading ---------------------------");

      final value = await DioHelper.getData(
        url: url ?? TOPHEADLINES,
        query: _query(country, category, keyWord),
      );

      final totalResults = _data(category, value);
      _paginationSuccessHelper(totalResults);
      emit(GetArticlesSuccessState());
    } catch (e) {
      isPaginationLoading = false;
      isEndPagination = true;
      print("get articles Error is -----------------> ${e.toString()}");
      emit(GetArticlesErrorState());
    }
  }

  UserModel? userModel;

  void getUser() {
    emit(GetUserLoadingState());
    fireStore.collection("users").doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print("The error is --------------->${error.toString()}");
      emit(GetUserErrorState());
    });
  }

  _query(String? country, String? category, String? keyWord) => {
        "page": page,
        "pageSize": 20,
        if (category != "search") ...{
          "country": country ?? "eg",
          "category": category,
        },
        if (category == "search") "q": keyWord,
        "apiKey": "2fa3c76635c046498f322bb7e7ff4484",
        //40e8e5accae049fda753f567995efc4a
      };

  int _data(String category, value) {
    final response = ArticlesResponse.fromJson(value.data);
    final totalResults = response.totalResults;
    print("total results --------------------->$totalResults");

    final isBooked = List.generate(totalResults, (index) => false);

    switch (category) {
      case "business":
        {
          businessArticles = [];
          isBookedBusiness = [];
          businessArticles.addAll(response.articles);
          isBookedBusiness = isBooked;
        }
        break;

      case "general":
        {
          regionArticles = [];
          isBookedRegion = [];
          regionArticles.addAll(response.articles);
          isBookedRegion = isBooked;
        }
        break;

      case "search":
        {
          searchArticles.addAll(response.articles);
          if (isBookedSearch.isEmpty) {
            isBookedSearch = isBooked;
          }
        }
        break;

      default:
        {
          articlesOfCategory = [];
          isBookedCategory = [];
          articlesOfCategory.addAll(response.articles);
          isBookedCategory = isBooked;
        }
        break;
    }
    return totalResults;
  }

  void _paginationSuccessHelper(int totalResults) {
    isPaginationLoading = false;

    final maxPages = totalResults ~/ 20;

    if (totalResults % 20 != 0) {
      if (page < maxPages + 1) {
        page++;
      }
      if (page == maxPages + 1) {
        isEndPagination = true;
      }
    } else {
      if (page < maxPages) {
        page++;
      }
      if (page == maxPages) {
        isEndPagination = true;
      }
    }
  }
}
