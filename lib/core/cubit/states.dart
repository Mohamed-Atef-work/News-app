abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppGetUserDataLoadingState extends AppStates {}

class AppGetUserDataSuccessState extends AppStates {}

class AppGetUserDataErrorState extends AppStates {}

class UpLoadMarkedArticleLoadingState extends AppStates {}

class UpLoadMarkedArticleSuccessState extends AppStates {}

class UpLoadMarkedArticleErrorState extends AppStates {}

class DeleteMarkedArticleLoadingState extends AppStates {}

class DeleteMarkedArticleSuccessState extends AppStates {}

class DeleteMarkedArticleErrorState extends AppStates {}

class EnsureLoadingState extends AppStates {}

class EnsureSuccessExistsState extends AppStates {}

class EnsureSuccessNotExistsState extends AppStates {}

class EnsureErrorState extends AppStates {}

class GetMarkedArticleLoadingState extends AppStates {}

class GetMarkedArticleSuccessState extends AppStates {}

class GetMarkedArticleErrorState extends AppStates {}

class ChangeLanguageState extends AppStates {}
