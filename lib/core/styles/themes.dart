import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  textTheme: _lightTextThem(),
  appBarTheme: _lightAppBarTheme(),
  //primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: primaryColor,
  outlinedButtonTheme: _outlinedButtonThem(),
  inputDecorationTheme: _inputDecorationTheme(),
  bottomNavigationBarTheme: _lightBottomNavigationBarTheme(),
);

_lightTextThem() => const TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        height: 1.4,
      ),
    );

_lightAppBarTheme() => const AppBarTheme(
      elevation: 0.0,
      titleSpacing: 20.0,
      backgroundColor: primaryColor,
      //iconTheme: IconThemeData(color: Colors.black),
      /*systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        //statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),*/
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      //centerTitle: true,
    );

_inputDecorationTheme() => InputDecorationTheme(
      filled: true,
      fillColor: secondaryColor,
      border: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(28)),
      contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
    );

_outlinedButtonThem() => OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: darkOrange,
        fixedSize: const Size(double.maxFinite, 53),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: secondaryColor)),
      ),
    );

_lightBottomNavigationBarTheme() => const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.white,
      backgroundColor: primaryColor,
      elevation: 0.0,
    );
