
import 'package:flutter/material.dart';
import 'package:scheduling_algorithm/colors.dart';

bool light = true;
ThemeData darkTheme = ThemeData(
    accentColor: darkAccentColor,
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,

    buttonTheme: ButtonThemeData(
        buttonColor: darkButtonColor,
        disabledColor: Colors.black
    )
);

ThemeData lightTheme = ThemeData(
    accentColor: lightAccentColor,
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,

    buttonTheme: ButtonThemeData(
        buttonColor: lightButtonColor,
        disabledColor: Colors.black
    )
);