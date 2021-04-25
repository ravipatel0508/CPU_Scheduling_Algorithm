import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scheduling_algorithm/dashboard.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //set time to load the new page
    Future.delayed(Duration(milliseconds: 4400), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
          height: 200,
          width: 200,
          child: Lottie.asset('assets/splash.json'),
        )
      ),
    );
  }
}