import 'package:flutter/material.dart';
import 'package:pick_champ/core/theme/app_color_scheme.dart';
import 'package:pick_champ/core/theme/app_text_style.dart';
import 'package:pick_champ/core/theme/custom_theme.dart';

class DarkThemeManager implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(
    useMaterial3: true,
    indicatorColor: Colors.white,
    canvasColor: const Color(0XFF4b5a60ff),
    scaffoldBackgroundColor: const Color(0xFF1F1F2E),
    primaryColor: Colors.brown,
    primaryColorDark: Colors.blue.shade200,
    dividerColor: Colors.white70,
    cardColor: Colors.blueAccent.shade200,
    colorScheme: AppColorScheme.darkColorScheme,
    iconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(centerTitle: false),
    textTheme: TextTheme(
      bodyLarge: AppTextStyle.headline38.copyWith(color: Colors.white),
      bodyMedium: AppTextStyle.headline34.copyWith(color: Colors.white),
      bodySmall: AppTextStyle.headline28.copyWith(color: Colors.white),
      displayLarge: AppTextStyle.headline28.copyWith(color: Colors.white),
      displayMedium: AppTextStyle.headline26.copyWith(color: Colors.white),
      displaySmall: AppTextStyle.headline24.copyWith(color: Colors.white),
      headlineLarge: AppTextStyle.headline20.copyWith(color: Colors.white),
      headlineMedium: AppTextStyle.headline18.copyWith(
        color: Colors.white,
      ),
      headlineSmall: AppTextStyle.headline16.copyWith(color: Colors.white),
      labelLarge: AppTextStyle.headline14.copyWith(color: Colors.white),
      labelMedium: AppTextStyle.headline12.copyWith(color: Colors.white),
      labelSmall: AppTextStyle.headline10.copyWith(color: Colors.white),
    ),
  );
}
