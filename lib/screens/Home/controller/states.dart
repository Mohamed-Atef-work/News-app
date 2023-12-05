import '../../../core/models/articleModel.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class RegionChangeBottomNavState extends HomeStates {}

class BusinessChangeBottomNavState extends HomeStates {}

class AllCategoriesChangeBottomNavState extends HomeStates {}

class SearchChangeBottomNavState extends HomeStates {}

class GetArticlesLoadingState extends HomeStates {}

class GetArticlesSuccessState extends HomeStates {}

class GetCategoriesArticlesSuccessState extends HomeStates {
  late ArticlesResponse? categoriesModel;

  GetCategoriesArticlesSuccessState({
    required this.categoriesModel,
  });
}

class GetArticlesErrorState extends HomeStates {}

class BookMarkState extends HomeStates {}

class GetUserSuccessState extends HomeStates {}

class GetUserErrorState extends HomeStates {}

class GetUserLoadingState extends HomeStates {}
