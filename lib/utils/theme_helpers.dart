import 'package:flutter/material.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/text_themes.dart';

class ThemeHelpers {

  static ThemeData themeData = ThemeData(
    useMaterial3: true
  ).copyWith(
    colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
    ),
    iconTheme: IconThemeData(
      size: 22
    ),
    textTheme: TextThemes.textTheme(color: primaryBlack),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryWhite,
      scrolledUnderElevation: 0,
      surfaceTintColor: primaryWhite,
      elevation: 0,
      shadowColor: Colors.black12
    ),
    scaffoldBackgroundColor: panelBackground,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: kEnabledBorder,
      focusedBorder: kFocusedBorder,
      errorBorder: kErrorBorder,
      disabledBorder: kDisabledBorder,
      focusedErrorBorder: kFocusedErrorBorder,
      filled: true,
      fillColor: primaryGrey20
    )
  );

}