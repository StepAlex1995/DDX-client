import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


final darkAppThem = ThemeData(
  dividerColor: AppColor.semiWhite,
  primaryColor: AppColor.primaryColor,
  canvasColor: AppColor.transparentColor,
  disabledColor: AppColor.disabledColor,
  primarySwatch: Colors.yellow,
  cardColor: AppColor.darkBackgroundColor,
  colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColor.primaryColor,
      onPrimary: AppColor.mainTextColor,
      secondary: AppColor.secondaryAccentColor,
      onSecondary: AppColor.secondaryAccentColor,
      error: Colors.red,
      onError: Colors.red,
      surface: AppColor.backgroundColor,
      onSurface: AppColor.backgroundColor),
  secondaryHeaderColor: Colors.grey,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.red,
    selectionHandleColor: Colors.red,
    selectionColor:
        Colors.red.withOpacity(0.5), // Change the text selection color
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: AppColor.backgroundColor,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 55,
      fontWeight: FontWeight.bold,
      color: AppColor.titleTextColor,
    ),
    bodyMedium: TextStyle(
      //main
      color: AppColor.editTextColor,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      //error
      color: AppColor.primaryColor,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      //title
      color: AppColor.mainTextColor,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      //editText
      color: AppColor.hintTextColor,
      fontSize: 20,
    ),
    titleSmall: TextStyle(
      //editText
      color: AppColor.hintTextColor,
      fontSize: 14,
    ),
  ),
  cupertinoOverrideTheme: const CupertinoThemeData(brightness: Brightness.dark),
);

class AppColor {
  static const darkBackgroundColor = Color.fromARGB(255, 27, 28, 33);
  static const backgroundColor = Color.fromARGB(255, 47, 48, 53);
  static const primaryColor = Color.fromARGB(255, 223, 86, 52);
  static const disabledColor = Color.fromARGB(155, 183, 56, 22);
  static const accentColor = Colors.yellow;// Color.fromARGB(255, 0, 255, 0);
  static const mainTextColor = Color.fromARGB(255, 254, 254, 254);
  static const titleTextColor = Color.fromARGB(255, 254, 254, 254);
  static const editTextColor = Color.fromARGB(255, 254, 254, 254);
  static const hintTextColor = Color.fromARGB(255, 164, 164, 164);
  static const transparentColor = Color.fromARGB(0, 0, 0, 0);
  static const semiWhite = Color.fromARGB(255, 112, 113, 115);
  static const badGrade = Colors.red;
  static const okGrade = Colors.yellow;
  static const goodGrade = Colors.green;

  static const appGrey = Color.fromARGB(255, 82, 83, 85);

//static const secondaryAccentColor = Color.fromARGB(255, 10, 132, 255);
  static const secondaryAccentColor = Color.fromARGB(255, 74, 97, 193);
}
