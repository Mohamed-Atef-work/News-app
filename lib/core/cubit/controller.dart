import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/components/navigateAndFinish.dart';
import 'package:news/core/components/navigator.dart';
import 'package:news/core/cubit/states.dart';
import 'package:news/core/dataBase/local/cache_helper.dart';
import 'package:news/screens/login/cubit/controller.dart';
import 'package:news/screens/login/view.dart';
import 'package:news/screens/profile/cubit/controller.dart';
import 'package:news/screens/register/model.dart';
import 'package:news/screens/splash/view.dart';
import 'package:news/screens/splash/viewTwo.dart';

import '../components/webView.dart';
import '../dataBase/local/constants.dart';
import '../models/articleModel.dart';

class AppController extends Cubit<AppStates> {
  AppController() : super(AppInitialState());

  static AppController get(context) => BlocProvider.of(context);

  late FirebaseFirestore fireStore = FirebaseFirestore.instance;

  late final GlobalKey<FormState> settingsFormKey = GlobalKey<FormState>();
  late final settingsEmailController = TextEditingController();
  late final settingsPasswordController = TextEditingController();

  bool isValidPassword(String input) {
    // Check the length of the input.
    if (input.length < 8) {
      return false;
    }

    // Check if the input contains only alphabets.
    final isAlphabetic = RegExp(r'^[a-zA-Z]+$').hasMatch(input);
    if (isAlphabetic) {
      return false;
    }

    // Check if the input contains only digits.
    final isNumeric = int.tryParse(input) != null;
    if (isNumeric) {
      return false;
    }

    // All conditions passed, so the input is valid.
    return true;
  }

  UserModel? userModel;

  void getUser() {
    emit(AppGetUserDataLoadingState());

    // get user
    fireStore.collection("users").doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      country = userModel!.country;
      uId = userModel!.uId;
      CacheHelper.saveData(
        key: "uId",
        value: userModel!.uId,
      ).then((value) => print("The user id is ----------------------->${uId}"));
      CacheHelper.saveData(
        key: "lang",
        value: userModel!.language,
      );
      emit(AppGetUserDataSuccessState());
    }).catchError((error) {
      print("The error is --------------->${error.toString()}");
      emit(AppGetUserDataErrorState());
    });
  }

  void upLoadBookMarkedArticle({
    required int index,
    required Articles article,
    required Map<int, String> markedArticlesMap,
  }) {
    emit(UpLoadMarkedArticleLoadingState());
    fireStore
        .collection("bookMarked")
        .doc(userModel!.uId)
        .collection("bookMarked")
        .add(article.toJson())
        .then((value) {
      markedArticlesMap[index] = value.id;
      emit(UpLoadMarkedArticleSuccessState());
    }).catchError((error) {
      print(
          "The error of upLoading the Marked article is --------------->${error.toString()}");
      emit(UpLoadMarkedArticleErrorState());
    });
  }

  late Map<int, String> markedArticlesIdsGeneral = {};
  late Map<int, String> markedArticlesIdsBusiness = {};
  late Map<int, String> markedArticlesIdsAllCategories = {};
  late Map<int, String> markedArticlesIdsBookMarked = {};
  late Map<int, String> markedArticlesIdsSearch = {};

  //late List<String> markedArticlesIds = [];
  //late List<int> markedArticlesIndexes = [];

  late List<Articles> bookMarkedArticles = [];
  late List<String> bookMarkedArticlesIds = [];

  void deleteFromBookMarked({
    required String articleId,
  }) {
    emit(DeleteMarkedArticleLoadingState());
    fireStore
        .collection("bookMarked")
        .doc(userModel!.uId)
        .collection("bookMarked")
        .doc(articleId)
        .delete()
        .then((value) {
      emit(DeleteMarkedArticleSuccessState());
    }).catchError((error) {
      print(
          "The error of upLoading the Marked article is --------------->${error.toString()}");
      emit(DeleteMarkedArticleErrorState());
    });
  }

  void ensureArticleExistsThenUpLoadOrNot({
    required int index,
    required Articles article,
    required Map<int, String> markedArticlesMap,
  }) {
    emit(EnsureLoadingState());

    /*int index = bookMarkedArticles.indexWhere((search) => search == article);
    print("The index is ---------------->${index}");*/

    if (bookMarkedArticles.isNotEmpty) {
      int score = search(article: article);
      print("The score is ---------------->${score}");
      if (score == 0) {
        upLoadBookMarkedArticle(
          index: index,
          article: article,
          markedArticlesMap: markedArticlesMap,
        );
      }
    } else {
      print("The article ----------------->doesn't exit Because it is empty");
      //emit(EnsureSuccessNotExistsState());
      upLoadBookMarkedArticle(
        index: index,
        article: article,
        markedArticlesMap: markedArticlesMap,
      );
    }
  }

  int search({required Articles article}) {
    int score = 0;

    for (int search = 0; search < bookMarkedArticles.length; search++) {
      if (article.title == bookMarkedArticles[search].title) {
        print("The article ----------------->exits");
        //emit(EnsureSuccessExistsState());
        score = 1;
        return score;
      } else {
        print("The article ----------------->doesn't exit");
        //emit(EnsureSuccessNotExistsState());
      }
    }
    return score;
  }

  void listenToTheChangesOnMarkedArticles() {
    fireStore
        .collection("bookMarked")
        .doc(uId)
        .collection("bookMarked")
        .snapshots()
        .listen((event) {
      bookMarkedArticles = [];
      bookMarkedArticlesIds = [];
      for (var element in event.docs) {
        bookMarkedArticles.add(Articles.fromJson(element.data()));
        bookMarkedArticlesIds.add(element.id);
      }
      emit(GetMarkedArticleSuccessState());
    });
  }

  void changeAppLangState() {
    emit(ChangeLanguageState());
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

  Locale localeCallBack(
    Locale? locale,
    Iterable<Locale> supportedLocales,
  ) {
    if (locale == null) {
      return supportedLocales.last;
    }
    for (var supportedLocale in supportedLocales) {
      if (locale.languageCode == supportedLocale.languageCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.last;
  }

  void logOut({
    required BuildContext context,
  }) {
    CacheHelper.removeData(
      key: "uId",
    ).then((value) {
      CacheHelper.removeData(
        key: "lang",
      );
      navigateAndFinish(context: context, widget: const LoginScreen());
    });
    AppController.get(context).bookMarkedArticles.clear();
    AppController.get(context).userModel = null;
    ProfileController.get(context).userModel = null;
    LoginController.get(context).userModel = null;
  }

  Widget startScreen() {
    Widget startScreen = const SplashScreenThenOnBoarding();
    if (uId != null) {
      startScreen = const SplashScreen();
    }
    return startScreen;
  }
}
