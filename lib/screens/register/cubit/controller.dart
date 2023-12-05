import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/dataBase/local/cache_helper.dart';
import 'package:news/screens/register/cubit/states.dart';
import 'package:news/screens/register/model.dart';

class RegisterController extends Cubit<RegisterStates> {
  RegisterController() : super(RegisterInitialState());

  static RegisterController get(context) => BlocProvider.of(context);

  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final nameController = TextEditingController();
  late final emailController = TextEditingController();
  late final phoneController = TextEditingController();
  late final passwordController = TextEditingController();
  bool isSecured = false;

  void changVisibility() {
    isSecured = !isSecured;
    emit(ChangVisibilityState());
  }

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

  late final firStore = FirebaseFirestore.instance;
  late final fireStorage = FirebaseStorage.instance;
  late final firAuth = FirebaseAuth.instance;

  void creteUserWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    emit(CreateUserLoadingState());
    firAuth
        .createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((value) {
      upLoadUser(
        name: nameController.text,
        uId: value.user!.uid,
        email: email,
        phone: phoneController.text,
        age: 10,
        bio: "Love Reading!",
        image:
            "https://thumbs.dreamstime.com/b/newspaper-good-news-coffee-25063632.jpg",
        language: "ar",
        country: "eg",
      );
      CacheHelper.saveData(
        key: "country",
        value: "eg",
      );
      emit(CreateUserSuccessState());
    }).catchError((error) {
      print(
          "The error of the creation is ----------------------->${error.toString()}");
      emit(CreateUserErrorState(error: error.toString()));
    });
  }

  void upLoadUser({
    required String name,
    required String uId,
    required String email,
    required String phone,
    required String image,
    required String bio,
    required int age,
    required String language,
    required String country,
  }) {
    emit(RegisterUpLoadUserLoadingState());
    UserModel userModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      country: country,
      language: language,
      uId: uId,
      bio: bio,
      age: age,
      image: image,
    );
    firStore
        .collection("users")
        .doc(uId)
        .set(userModel.toJson())
        .then((value) {})
        .catchError((error) {
      emit(RegisterUpLoadUserErrorState(error: error.toString()));
    });

    /*firStore.collection("profileImage").doc(uId).set({
      "profileImage": image,
    }).then((value) {
      emit(RegisterUpLoadUserSuccessState());
    }).catchError((error) {
      emit(RegisterUpLoadUserErrorState(error: error.toString()));
    });*/
  }
}
