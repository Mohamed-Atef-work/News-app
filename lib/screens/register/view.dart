import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/components/appOutLinedButton.dart';
import 'package:news/core/components/appTextFormField.dart';
import 'package:news/core/components/navigator.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/screens/login/view.dart';

import '../../core/components/appText.dart';
import 'cubit/controller.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterController(),
      child: BlocConsumer<RegisterController, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterUpLoadUserErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: DefaultText(
                  text: state.error,
                  textAlign: TextAlign.center,
                ),
                duration: const Duration(seconds: 3),
              ),
            );
          }
          if (state is CreateUserErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: DefaultText(
                  text: state.error.substring(30),
                  textAlign: TextAlign.center,
                ),
                duration: const Duration(seconds: 3),
              ),
            );
          }
          if (state is CreateUserSuccessState) {
            navigateTo(
              context: context,
              widget: const LoginScreen(),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0XFFff9100),
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Form(
                    key: RegisterController.get(context).formKey,
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.register,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          AppLocalizations.of(context)!
                              .registerNowAndConnectToTheWorld,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        CustomTextField(
                          controller:
                              RegisterController.get(context).nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseEnterYourName;
                            }
                            return null;
                          },
                          labelText: AppLocalizations.of(context)!.name,
                          prefixIcon: Icons.person,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller:
                              RegisterController.get(context).emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseEnterYourEmail;
                            }
                            return null;
                          },
                          labelText: AppLocalizations.of(context)!.email,
                          prefixIcon: Icons.email,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller:
                              RegisterController.get(context).phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseEnterYourPhone;
                            }
                            return null;
                          },
                          labelText: AppLocalizations.of(context)!.phone,
                          prefixIcon: Icons.phone,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: RegisterController.get(context)
                              .passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseEnterYourPassword;
                            } else if (value.isNotEmpty &&
                                RegisterController.get(context).isValidPassword(
                                        RegisterController.get(context)
                                            .passwordController
                                            .text) ==
                                    false) {
                              return AppLocalizations.of(context)!
                                  .passwordIsNotValid;
                            }
                            return null;
                          },
                          labelText: AppLocalizations.of(context)!.password,
                          prefixIcon: Icons.password_outlined,
                          suffix: GestureDetector(
                            onTap: () {
                              RegisterController.get(context).changVisibility();
                            },
                            child: Icon(
                                RegisterController.get(context).isSecured
                                    ? Icons.visibility_off_outlined
                                    : Icons.remove_red_eye),
                          ),
                          obscureText:
                              RegisterController.get(context).isSecured,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is RegisterUpLoadUserLoadingState ||
                              state is CreateUserLoadingState,
                          builder: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          fallback: (context) => AppOutlinedButton(
                            onPressed: () {
                              if (RegisterController.get(context)
                                  .formKey
                                  .currentState!
                                  .validate()) {
                                RegisterController.get(context)
                                    .creteUserWithEmailAndPassword(
                                  email: RegisterController.get(context)
                                      .emailController
                                      .text,
                                  password: RegisterController.get(context)
                                      .passwordController
                                      .text,
                                );
                              }
                            },
                            text: AppLocalizations.of(context)!.register,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
