import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/screens/login/cubit/states.dart';
import 'package:news/screens/register/model.dart';

import '../../../core/dataBase/local/cache_helper.dart';
import '../../../core/dataBase/local/constants.dart';

class LoginController extends Cubit<LoginStates> {
  LoginController() : super(LoginInitialState());

  static LoginController get(context) => BlocProvider.of(context);

  late final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();

  //late final FirebaseAuth fireAuth = FirebaseAuth.instance;

  void login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((value) {
      print("LoginIN----------------------------------------------");
      getUser(userID: value.user!.uid);
      print("${value.user!.uid}---------------------------------");
    }).catchError((error) {
      emit(LoginErrorState(error: error.toString()));
    });
  }

  UserModel? userModel;

  void getUser({required String userID}) {
    // get user
    fireStore.collection("users").doc(userID).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      country = userModel!.country;
      uId = userModel!.uId;
      emit(LoginSuccessState(uId: userID));
      CacheHelper.saveData(key: "uId", value: userModel!.uId).then(
          (value) => print("The user id is ----------------------->${uId}"));
      CacheHelper.saveData(key: "lang", value: userModel!.language);
    }).catchError((error) {
      print("The error is --------------->${error.toString()}");
      emit(LoginGetUserErrorState());
    });
  }

  late bool isSecured = false;
  void changeVisibility() {
    isSecured = !isSecured;
    emit(ChangeVisibilityState());
  }
}
