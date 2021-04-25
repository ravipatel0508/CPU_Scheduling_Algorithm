
import 'package:flutter/material.dart';

import 'colors.dart';

bool light = false;
ThemeData darkTheme = ThemeData(
    fontFamily: 'poppins',
    accentColor: darkAccentColor,
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,

    buttonTheme: ButtonThemeData(
        buttonColor: darkButtonColor,
        disabledColor: Colors.black
    )
);

ThemeData lightTheme = ThemeData(
    fontFamily: 'poppins',
    accentColor: lightAccentColor,
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    backgroundColor: Colors.blueGrey[50],

    buttonTheme: ButtonThemeData(
        buttonColor: lightButtonColor,
        disabledColor: Colors.black
    )
);