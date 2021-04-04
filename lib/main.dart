import 'package:flutter/material.dart';
import 'package:scheduling_algorithm/colorAndTheme/appTheme.dart';
import 'package:scheduling_algorithm/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}