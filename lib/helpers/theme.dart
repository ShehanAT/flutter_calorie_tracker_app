import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    fontFamily: 'Nunito',
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: Colors.white, brightness: Brightness.dark),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: AppTheme.primaryColor, backgroundColor: Colors.white),
    dividerColor: Colors.black12,
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
      centerTitle: true,
      toolbarTextStyle: TextStyle(color: Colors.white),
      iconTheme: IconThemeData(),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: 'Nunito',
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
      ),
    ));

final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.green,
    primaryColor: Colors.white,
    fontFamily: 'Nunito',
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: Colors.white, brightness: Brightness.dark),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white, backgroundColor: Colors.white),
    dividerColor: Colors.white54,
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
      centerTitle: true,
      toolbarTextStyle: TextStyle(color: Colors.white),
      iconTheme: IconThemeData(color: AppTheme.primaryColor),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: 'Nunito',
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
      ),
    ));
