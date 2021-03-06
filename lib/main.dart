import 'package:flutter/material.dart';
import 'package:scheduling_algorithm/splashScreen.dart';

import 'colorAndTheme/appTheme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: light ? lightTheme : darkTheme,
      home: SplashScreen(),
    );
  }
}