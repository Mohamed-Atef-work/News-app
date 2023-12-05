import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/cubit/controller.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/screens/HomeScreens/drawer/view.dart';
import 'package:news/screens/profile/cubit/states.dart';
import '../../core/components/appTextFormField.dart';
import '../../core/components/appText.dart';
import '../../core/dataBase/local/constants.dart';
import 'cubit/controller.dart';
import 'widgets/countriesAndLanguages.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileController()
        ..getUser(
          uId: uId!,
        ),
      child: BlocConsumer<ProfileController, ProfileStates>(
        listener: (context, state) {
          if (state is UpDateProfileSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: DefaultText(
                  text: AppLocalizations.of(context)!.success,
                  textAlign: TextAlign.center,
                  fontSize: 20,
                ),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          if (ProfileController.get(context).userModel != null) {
            ProfileController.get(context).nameController.text =
                ProfileController.get(context).userModel!.name;
            ProfileController.get(context).emailController.text =
                ProfileController.get(context).userModel!.email;
            ProfileController.get(context).phoneController.text =
                ProfileController.get(context).userModel!.phone;
          }
          return Scaffold(
            appBar: AppBar(
              title: DefaultText(
                text: AppLocalizations.of(context)!.profile,
                fontSize: 24,
              ),
            ),
            drawer: AppDrawer(),
            body: ProfileController.get(context).userModel != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: ProfileController.get(context).profileFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 70,
                                    foregroundImage:
                                        ProfileController.get(context)
                                                    .profileImage !=
                                                null
                                            ? Image.file(
                                                ProfileController.get(context)
                                                    .profileImage!,
                                              ).image
                                            : NetworkImage(
                                                ProfileController.get(context)
                                                    .userModel!
                                                    .image,
                                              ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.grey.shade100,
                                    child: GestureDetector(
                                      onTap: () {
                                        ProfileController.get(context)
                                            .getLocalImage();
                                      },
                                      child: const Icon(
                                        Icons.photo_camera,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (ProfileController.get(context).profileImage !=
                                null)
                              const SizedBox(
                                height: 5,
                              ),
                            /*DefaultText(
                              text: ProfileController.get(context)
                                  .userModel!
                                  .name,
                              fontSize: 16,
                              textColor: const Color(0xFF4A4B4D),
                              fontWeight: FontWeight.bold,
                            ),*/
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Column(
                                        //mainAxisSize: ,
                                        children: [
                                          Text(
                                            AppController.get(context)
                                                .bookMarkedArticles
                                                .length
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .bookMarkedArticles,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DefaultText(
                                  text: ProfileController.get(context)
                                      .userModel!
                                      .email,
                                  fontSize: 16,
                                  textColor: const Color(0xFF4A4B4D),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                              onSubmitted: (value) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .pleaseEnterYourName;
                                }
                              },
                              keyboardType: TextInputType.text,
                              prefixIcon: Icons.person,
                              labelText: AppLocalizations.of(context)!.name,
                              controller:
                                  ProfileController.get(context).nameController,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            /*CustomTextField(
                              onSubmitted: (value) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter the Email";
                                }

                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.email,
                              labelText: "Email",
                              controller: ProfileController.get(context)
                                  .emailController,
                            ),
                            const SizedBox(
                              height: 15,
                            ),*/
                            CustomTextField(
                              onSubmitted: (value) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .pleaseEnterYourPhone;
                                }

                                return null;
                              },
                              keyboardType: TextInputType.phone,
                              prefixIcon: Icons.phone,
                              labelText: AppLocalizations.of(context)!.phone,
                              controller: ProfileController.get(context)
                                  .phoneController,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            /*CustomTextField(
                              obscureText:
                                  ProfileController.get(context).isSecured,
                              onSubmitted: (value) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter the Password";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              prefixIcon: Icons.password,
                              suffix: GestureDetector(
                                onTap: () {
                                  ProfileController.get(context).isSecured =
                                      !ProfileController.get(context).isSecured;
                                },
                                child: Icon(
                                  ProfileController.get(context).isSecured ==
                                          false
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off_outlined,
                                ),
                              ),
                              labelText: "Password",
                            ),*/
                            const SizedBox(
                              height: 15,
                            ),
                            DefaultText(
                              text: AppLocalizations.of(context)!.country,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              textColor: const Color(0xFF4A4B4D),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 50,
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    OneCountryOrLanguage(
                                  onTap: () {
                                    ProfileController.get(context)
                                        .chooseTheCountry(index: index);
                                  },
                                  countryOrLanguageName:
                                      ProfileController.get(context)
                                          .countries[index],
                                  countryOrLanguageColor:
                                      ProfileController.get(context)
                                                  .countryIndex ==
                                              index
                                          ? Colors.deepOrange
                                          : Colors.grey.shade100,
                                  textColor: ProfileController.get(context)
                                              .countryIndex ==
                                          index
                                      ? Colors.white
                                      : Colors.deepOrange,
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 5,
                                ),
                                itemCount: ProfileController.get(context)
                                    .countries
                                    .length,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            DefaultText(
                              text: AppLocalizations.of(context)!.language,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              textColor: const Color(0xFF4A4B4D),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 50,
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    OneCountryOrLanguage(
                                  onTap: () {
                                    ProfileController.get(context)
                                        .chooseTheLanguage(index: index);
                                  },
                                  countryOrLanguageName:
                                      ProfileController.get(context)
                                          .languages[index],
                                  countryOrLanguageColor:
                                      ProfileController.get(context)
                                                  .languageIndex ==
                                              index
                                          ? Colors.deepOrange
                                          : Colors.grey.shade100,
                                  textColor: ProfileController.get(context)
                                              .languageIndex ==
                                          index
                                      ? Colors.white
                                      : Colors.deepOrange,
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 5,
                                ),
                                itemCount: ProfileController.get(context)
                                    .languages
                                    .length,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            if (state is UpDateProfileLoadingState)
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: LinearProgressIndicator(),
                              ),
                            OutlinedButton(
                              onPressed: () {
                                if (ProfileController.get(context)
                                    .profileFormKey
                                    .currentState!
                                    .validate()) {
                                  if (ProfileController.get(context)
                                          .profileImage !=
                                      null) {
                                    ProfileController.get(context)
                                        .upLoadImage();
                                  } else {
                                    ProfileController.get(context).upDateUser(
                                      name: ProfileController.get(context)
                                          .nameController
                                          .text,
                                      uId: uId!,
                                      email: ProfileController.get(context)
                                          .userModel!
                                          .email,
                                      phone: ProfileController.get(context)
                                          .phoneController
                                          .text,
                                      image: ProfileController.get(context)
                                          .userModel!
                                          .image,
                                      age: ProfileController.get(context)
                                          .userModel!
                                          .age,
                                      bio: ProfileController.get(context)
                                          .userModel!
                                          .bio,
                                      language: ProfileController.get(context)
                                              .languages[
                                          ProfileController.get(context)
                                              .languageIndex],
                                      country: ProfileController.get(context)
                                              .countries[
                                          ProfileController.get(context)
                                              .countryIndex],
                                    );
                                  }
                                  AppController.get(context).userModel =
                                      ProfileController.get(context).userModel;
                                  print("good");
                                  // change the app language.
                                  if (isLanguageChanged) {
                                    AppController.get(context)
                                        .changeAppLangState();
                                    isLanguageChanged = false;
                                  }
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xFFFC6011),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.save,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
