import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/components/navigateAndFinish.dart';
import 'package:news/core/cubit/controller.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/screens/Home/view.dart';
import 'package:news/screens/login/cubit/states.dart';

import '../../core/components/appOutLinedButton.dart';
import '../../core/components/appText.dart';
import '../../core/components/appTextButton.dart';
import '../../core/components/appTextFormField.dart';
import '../../core/components/navigator.dart';
import '../register/view.dart';
import 'cubit/controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginController(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: Center(
          child: BlocConsumer<LoginController, LoginStates>(
            listener: (context, state) {
              if (state is LoginErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: DefaultText(
                      text: state.error.substring(30),
                      textAlign: TextAlign.center,
                    ),
                    duration: const Duration(
                      seconds: 3,
                    ),
                  ),
                );
              }
              if (state is LoginSuccessState) {
                //uId = state.uId;
                AppController.get(context).listenToTheChangesOnMarkedArticles();
                if (AppController.get(context).userModel == null) {
                  AppController.get(context).userModel =
                      LoginController.get(context).userModel;
                }
                navigateAndFinish(
                  context: context,
                  widget: const HomeLayOutScreen(),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Form(
                    key: LoginController.get(context).formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.login,
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                            AppLocalizations.of(context)!
                                .loginNowAndReadArticles,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey)),
                        const SizedBox(
                          height: 30.0,
                        ),
                        CustomTextField(
                          onSubmitted: (value) {},
                          controller:
                              LoginController.get(context).emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseEnterYourEmail;
                            }
                            return null;
                          },
                          labelText: AppLocalizations.of(context)!.email,
                          prefixIcon: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        CustomTextField(
                          onSubmitted: (value) {},
                          controller:
                              LoginController.get(context).passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseEnterYourPassword;
                            }
                            return null;
                          },
                          labelText: AppLocalizations.of(context)!.password,
                          prefixIcon: Icons.password,
                          obscureText: LoginController.get(context).isSecured,
                          suffix: GestureDetector(
                            onTap: () {
                              LoginController.get(context).changeVisibility();
                            },
                            child: state is LoginLoadingState
                                ? const SizedBox.shrink()
                                : Icon(
                                    LoginController.get(context).isSecured
                                        ? Icons.visibility_off_outlined
                                        : Icons.remove_red_eye,
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        state is LoginLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : AppOutlinedButton(
                                textColor: Colors.white,
                                onPressed: () {
                                  if (LoginController.get(context)
                                      .formKey
                                      .currentState!
                                      .validate()) {
                                    LoginController.get(context).login(
                                      email: LoginController.get(context)
                                          .emailController
                                          .text,
                                      password: LoginController.get(context)
                                          .passwordController
                                          .text,
                                    );
                                  }
                                },
                                height: 50,
                                //backgroundColor: Colors.deepOrange,
                                text: AppLocalizations.of(context)!.login,
                              ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.donNotHaveAnAccount,
                            ),
                            AppTextButton(
                                text: AppLocalizations.of(context)!.register,
                                onPressed: () {
                                  navigateTo(
                                    context: context,
                                    widget: const RegisterScreen(),
                                  );
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
