abstract class RegisterStates {}

class ChangVisibilityState extends RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterUpLoadUserSuccessState extends RegisterStates {}

class RegisterUpLoadUserLoadingState extends RegisterStates {}

class RegisterUpLoadUserErrorState extends RegisterStates {
  late final String error;

  RegisterUpLoadUserErrorState({required this.error});
}

class CreateUserSuccessState extends RegisterStates {}

class CreateUserLoadingState extends RegisterStates {}

class CreateUserErrorState extends RegisterStates {
  late final String error;

  CreateUserErrorState({required this.error});
}
