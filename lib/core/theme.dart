

import 'package:flutter/material.dart';

abstract class AppThemeData{

  static ThemeData get light{
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.black,
      splashColor: Colors.transparent,
      fontFamily: "BM",
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: Colors.black)
    );
  }

}