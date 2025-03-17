import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_web_project/core/theme/typography.dart';

import 'app_colors.dart';

class Themes {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        // fontFamily: AppTypography.font16Regular,
        scaffoldBackgroundColor: AppColors.white,
        primaryColor: AppColors.white,
        colorScheme: const ColorScheme.light(primary: AppColors.white),
        textSelectionTheme: const TextSelectionThemeData(
          // selectionColor: AppColors.gray,
          // selectionHandleColor: AppColors.gray,
          // cursorColor: AppColors.black,
        ),
        canvasColor: AppColors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.white,
            minimumSize: const Size(double.infinity, 61),
            textStyle: AppTypography.font12RegularZillaSlab.copyWith(
              color: AppColors.black,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 1,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Color(0xFF000000),
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            statusBarColor: AppColors.white,
          ),
          backgroundColor: AppColors.white,
          shadowColor: AppColors.transparent,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: AppColors.black,
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(decoration: TextDecoration.none),
          displayMedium: TextStyle(decoration: TextDecoration.none),
          displaySmall: TextStyle(decoration: TextDecoration.none),
          headlineLarge: TextStyle(decoration: TextDecoration.none),
          headlineMedium: TextStyle(decoration: TextDecoration.none),
          headlineSmall: TextStyle(decoration: TextDecoration.none),
          titleLarge: TextStyle(decoration: TextDecoration.none),
          titleMedium: TextStyle(decoration: TextDecoration.none),
          titleSmall: TextStyle(decoration: TextDecoration.none),
          bodyLarge: TextStyle(decoration: TextDecoration.none),
          bodyMedium: TextStyle(decoration: TextDecoration.none),
          bodySmall: TextStyle(decoration: TextDecoration.none),
          labelLarge: TextStyle(decoration: TextDecoration.none),
          labelMedium: TextStyle(decoration: TextDecoration.none),
          labelSmall: TextStyle(decoration: TextDecoration.none),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      );

  static ThemeData get light => lightTheme;

  static ThemeData get dark => lightTheme;
}
