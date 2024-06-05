import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/cubit/controller.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/screens/home_screens/drawer/view.dart';
import 'package:news/screens/profile/cubit/states.dart';
import '../../core/components/appOutLinedButton.dart';
import '../../core/components/appTextFormField.dart';
import '../../core/components/appText.dart';
import '../../core/dataBase/local/constants.dart';
import '../../core/styles/colors.dart';
import 'cubit/controller.dart';
import 'widgets/countriesAndLanguages.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final appController = AppController.get(context);
    return BlocProvider(
      create: (_) => ProfileController()..getUser(uId: uId!),
      child: BlocConsumer<ProfileController, ProfileStates>(
        listener: (context, state) {
          if (state is UpDateProfileSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: DefaultText(
                  fontSize: 20,
                  text: localization.success,
                  textAlign: TextAlign.center,
                ),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          final profileController = ProfileController.get(context);

          if (profileController.userModel != null) {
            profileController.nameController.text =
                profileController.userModel!.name;
            profileController.emailController.text =
                profileController.userModel!.email;
            profileController.phoneController.text =
                profileController.userModel!.phone;
          }
          return Scaffold(
            appBar: AppBar(
              title: DefaultText(text: localization.profile, fontSize: 24),
            ),
            drawer: const AppDrawer(),
            body: profileController.userModel != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: profileController.profileFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            Align(
                              alignment: Alignment.center,
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 70,
                                    backgroundColor: Colors.transparent,
                                    foregroundImage:
                                        profileController.profileImage != null
                                            ? Image.file(profileController
                                                    .profileImage!)
                                                .image
                                            : NetworkImage(profileController
                                                .userModel!.image),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.grey.shade100,
                                    child: GestureDetector(
                                      onTap: () =>
                                          profileController.getLocalImage(),
                                      child: const Icon(Icons.photo_camera),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (profileController.profileImage != null)
                              const SizedBox(height: 5),
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
                                            appController
                                                .bookMarkedArticles.length
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Text(
                                            localization.bookMarkedArticles,
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
                                  text: profileController.userModel!.email,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  textColor: const Color(0xFF4A4B4D),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            CustomTextField(
                              onSubmitted: (value) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return localization.pleaseEnterYourName;
                                }
                              },
                              prefixIcon: Icons.person,
                              labelText: localization.name,
                              keyboardType: TextInputType.text,
                              controller: profileController.nameController,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                              onSubmitted: (_) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return localization.pleaseEnterYourPhone;
                                }

                                return null;
                              },
                              keyboardType: TextInputType.phone,
                              prefixIcon: Icons.phone,
                              labelText: localization.phone,
                              controller: profileController.phoneController,
                            ),
                            const SizedBox(height: 15),
                            const SizedBox(height: 15),
                            DefaultText(
                              text: localization.country,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              textColor: const Color(0xFF4A4B4D),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 50,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: profileController.countries.length,
                                itemBuilder: (_, index) => OneCountryOrLanguage(
                                  onTap: () => profileController
                                      .chooseTheCountry(index: index),
                                  countryOrLanguageName:
                                      profileController.countries[index],
                                  countryOrLanguageColor:
                                      profileController.countryIndex == index
                                          ? Colors.deepOrange
                                          : Colors.grey.shade100,
                                  textColor:
                                      profileController.countryIndex == index
                                          ? Colors.white
                                          : Colors.deepOrange,
                                ),
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 5),
                              ),
                            ),
                            const SizedBox(height: 15),
                            DefaultText(
                              fontSize: 18,
                              text: localization.language,
                              fontWeight: FontWeight.bold,
                              textColor: const Color(0xFF4A4B4D),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 50,
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, index) => OneCountryOrLanguage(
                                  onTap: () => profileController
                                      .chooseTheLanguage(index: index),
                                  countryOrLanguageName:
                                      profileController.languages[index],
                                  countryOrLanguageColor:
                                      profileController.languageIndex == index
                                          ? Colors.deepOrange
                                          : Colors.grey.shade100,
                                  textColor:
                                      profileController.languageIndex == index
                                          ? Colors.white
                                          : Colors.deepOrange,
                                ),
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 5),
                                itemCount: profileController.languages.length,
                              ),
                            ),
                            const SizedBox(height: 15),
                            if (state is UpDateProfileLoadingState)
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: LinearProgressIndicator(),
                              ),
                            AppOutlinedButton(
                              onPressed: () {
                                if (profileController
                                    .profileFormKey.currentState!
                                    .validate()) {
                                  if (profileController.profileImage != null) {
                                    profileController.upLoadImage();
                                  } else {
                                    profileController.upDateUser(
                                      name:
                                          profileController.nameController.text,
                                      uId: uId!,
                                      email: profileController.userModel!.email,
                                      phone: profileController
                                          .phoneController.text,
                                      image: profileController.userModel!.image,
                                      age: profileController.userModel!.age,
                                      bio: profileController.userModel!.bio,
                                      language: profileController.languages[
                                          profileController.languageIndex],
                                      country: profileController.countries[
                                          profileController.countryIndex],
                                    );
                                  }
                                  appController.userModel =
                                      profileController.userModel;
                                  print("good");
                                  // change the app language.
                                  if (isLanguageChanged) {
                                    appController.changeAppLangState();
                                    isLanguageChanged = false;
                                  }
                                }
                              },
                              text: localization.save,
                              height: 53,
                            ),
                            const SizedBox(height: 15),
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
