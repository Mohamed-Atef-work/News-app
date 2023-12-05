
abstract class LoginStates {}

class ChangeVisibilityState extends LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  late final String uId;

  LoginSuccessState({
    required this.uId,
  });
}

class LoginLoadingState extends LoginStates {}

class LoginErrorState extends LoginStates {
  late final String error;

  LoginErrorState({
    required this.error,
  });
}

class LoginGetUserSuccessState extends LoginStates {}

class LoginGetUserLoadingState extends LoginStates {}

class LoginGetUserErrorState extends LoginStates {}
