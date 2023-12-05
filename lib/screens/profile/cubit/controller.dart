import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news/core/dataBase/local/cache_helper.dart';
import 'package:news/screens/profile/cubit/states.dart';
import 'package:news/screens/register/model.dart';

import '../../../core/dataBase/local/constants.dart';

class ProfileController extends Cubit<ProfileStates> {
  ProfileController() : super(ProfileInitialState());

  static ProfileController get(context) => BlocProvider.of(context);

  late final profileFormKey = GlobalKey<FormState>();

  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController phoneController = TextEditingController();
  //late final TextEditingController nameController = TextEditingController();

  late bool isSecured = true;

  late FirebaseFirestore fireStore = FirebaseFirestore.instance;
  late FirebaseStorage fireStorage = FirebaseStorage.instance;

  late final ImagePicker picker = ImagePicker();
  File? profileImage;

  Future<void> getLocalImage() async {
    emit(GetProfileImageLocalLoadingState());
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      profileImage = File(
        pickedImage.path,
      );
      emit(GetProfileImageLocalSuccessState());
    } else {
      print("--------->No image selected");
      emit(GetProfileImageLocalErrorState());
    }
  }

  /*void getRemoteImage() {
    fireStore.collection("profileImages").doc(uId).get().then((value) {
      userModel!.image = UserModel.imageFromJson(value.data()!);
      emit(ProfileGetUserDataSuccessState());
    }).catchError((getProfileImageError) {
      print("The error is --------------->${getProfileImageError.toString()}");
      emit(ProfileGetUserDataErrorState());
    });
  }*/

  UserModel? userModel;

  void getUser({required String uId}) {
    emit(ProfileGetUserDataLoadingState());

    // get user
    fireStore.collection("users").doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(ProfileGetUserDataSuccessState());
    }).catchError((error) {
      print("The error is --------------->${error.toString()}");
      emit(ProfileGetUserDataErrorState());
    });

    // get profileImage
    /*fireStore.collection("profileImages").doc(uId).get().then((value) {
      userModel!.image = UserModel.imageFromJson(value.data()!);
      emit(ProfileGetUserDataSuccessState());
    }).catchError((getProfileImageError) {
      print("The error is --------------->${getProfileImageError.toString()}");
      emit(ProfileGetUserDataErrorState());
    });*/
  }

  void upLoadImage() {
    emit(UpDateProfileLoadingState());
    fireStorage
        .ref()
        .child(
            "profileImages/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((profileImageUrl) {
        userModel!.image = profileImageUrl;
        profileImage = null;
        upDateUser(
          name: nameController.text,
          uId: userModel!.uId,
          email: emailController.text,
          phone: phoneController.text,
          image: profileImageUrl,
          language: userModel!.language,
          country: userModel!.country,
          bio: userModel!.bio,
          age: userModel!.age,
        );
      }).catchError((error) {
        emit(UpDateProfileErrorState());
      });
    }).catchError((bigError) {
      emit(UpDateProfileErrorState());
    });
  }

  //AppController? appController;

  void upDateUser({
    required String name,
    required String uId,
    required String email,
    required String phone,
    required String image,
    required int age,
    required String bio,
    required String language,
    required String country,
  }) {
    this.userModel!.name = nameController.text;
    this.userModel!.phone = phoneController.text;

    emit(UpDateProfileLoadingState());

    UserModel userModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      country: country,
      language: language,
      uId: uId,
      image: image,
      age: age,
      bio: bio,
    );
    fireStore
        .collection("users")
        .doc(uId)
        .set(userModel.toJson())
        .then((value) {
      //appController!.userModel = userModel;

      emit(UpDateProfileSuccessState());
    }).catchError((error) {
      emit(UpDateProfileErrorState());
    });

    /*firStore.collection("profileImage").doc(uId).set({
      "profileImage": image,
    }).then((value) {
      emit(UpLoadUserSuccessState());
    }).catchError((error) {
      emit(UpLoadUserErrorState(error: error.toString()));
    });*/
  }

  late int languageIndex = searchForTheIndex(
    list: languages,
    langeOrCountry: userModel!.language,
  );
  late int countryIndex = searchForTheIndex(
    list: countries,
    langeOrCountry: userModel!.country,
  );

  int searchForTheIndex({
    required List<String> list,
    required String langeOrCountry,
  }) {
    int searchedIndex = 0;

    for (int index = 0; index < list.length; index++) {
      if (list[index] == langeOrCountry) {
        searchedIndex = index;
        break;
      }
    }
    if (list == languages) {
      language = languages[searchedIndex];
      /*CacheHelper.saveData(
        key: "language",
        value: language,
      );*/
      //userModel!.language = languages[searchedIndex];
    } else if (list == countries) {
      country = countries[searchedIndex];
      //userModel!.country = country[searchedIndex];

      print("The country is ----------->${country}");
      CacheHelper.saveData(
        key: "country",
        value: country,
      );
    }
    return searchedIndex;
  }

//  Change the country of the application and the languages then.
  void chooseTheLanguage({
    required int index,
  }) {
    languageIndex = index;
    language = languages[index];
    userModel!.language = languages[index];
    isLanguageChanged = true;
    CacheHelper.saveData(key: "lang", value: language);
    print("the language is ------------>${language}");
    emit(ProfileChooseCountryOrLanguageState());
  }

  void chooseTheCountry({
    required int index,
  }) {
    countryIndex = index;
    country = countries[index];
    userModel!.country = countries[index];
    //isCountryChanged = true;
    //CacheHelper.saveData(key: "country", value: country);
    print("the country is ------------>${country}");
    emit(ProfileChooseCountryOrLanguageState());
  }

  late final List<String> languages = [
    "ar",
    "en",
    "fr",
  ];
  late final List<String> countries = [
    "ae",
    "ar",
    "at",
    "au",
    "be",
    "bg",
    "br",
    "ca",
    "ch",
    "cn",
    "co",
    "cu",
    "cz",
    "de",
    "eg",
    "fr",
    "gb",
    "gr",
    "hk",
    "hu",
    "id",
    "ie",
    "il",
    "in",
    "it",
    "jp",
    "kr",
    "lt",
    "lv",
    "ma",
    "mx",
    "my",
    "ng",
    "nl",
    "no",
    "nz",
    "ph",
    "pl",
    "pt",
    "ro",
    "rs",
    "ru",
    "sa",
    "se",
    "sg",
    "si",
    "sk",
    "th",
    "tr",
    "tw",
    "ua",
    "us",
    "ve",
    "za",
  ];
}
