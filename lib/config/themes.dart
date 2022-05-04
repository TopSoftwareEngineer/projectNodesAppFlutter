import 'package:flutter/material.dart';
import 'package:projectx/config/colors.dart';

class PxAppTheme {
  static ThemeData initialTheme() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: kViolet,
        centerTitle: true,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: kGray,
          primary: kBlack,
        ),
      ),
    );
  }
}
