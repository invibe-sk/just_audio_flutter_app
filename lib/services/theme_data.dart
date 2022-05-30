import 'package:flutter/material.dart';

class AppThemeData {
  static const Color primaryColor = Color(0xFFED711B);

  static ThemeData get() {
    return ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(color: primaryColor),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryColor),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: primaryColor),
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(selectedItemColor: primaryColor),
      textTheme: const TextTheme(
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black),
        button: TextStyle(fontSize: 18),
        subtitle1: TextStyle(color: Colors.black, fontSize: 18), // text input color
        headline3: TextStyle(color: Colors.black, fontSize: 18, height: 1),
      ),
      primaryColor: primaryColor,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.green),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(splashFactory: NoSplash.splashFactory),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(primaryColor),
          overlayColor: MaterialStateProperty.all(primaryColor),
          splashFactory: NoSplash.splashFactory,
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: const TextStyle(fontSize: 20, height: 1.5, color: Colors.black),
        hintStyle: const TextStyle(fontSize: 18, height: 1.5, color: Colors.black),
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.green),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
