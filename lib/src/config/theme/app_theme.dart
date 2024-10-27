import 'package:flutter/material.dart';
import 'package:tabark_innov8/src/core/utils/constants.dart';

import '../../core/utils/app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.mainColor,
    hintColor: AppColors.hintColor,
    indicatorColor: AppColors.mainColor,
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.mainColor,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.mainColor,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.mainColor,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    fontFamily: AppConstant.fontFamily,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white,
        height: 1.3,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
