import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheduling_algorithm/body_page.dart';
import 'package:scheduling_algorithm/colorAndTheme/colors.dart';

import 'colorAndTheme/appTheme.dart';

class Implementation extends StatefulWidget {
  @override
  _ImplementationState createState() => _ImplementationState() ;
}

class _ImplementationState extends State<Implementation> {
  AssetImage img = new AssetImage('assets/sun.png');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: light ? lightTheme : darkTheme,
      home: Scaffold(
            appBar: AppBar(
              title: Center(child: Text('Scheduling Algorithms', style: GoogleFonts.poppins())),
              backgroundColor: light ? lightPrimaryColor : darkPrimaryColor,
              actions: <Widget>[Switch(
                  activeThumbImage: AssetImage('assets/sun.png'),
                  inactiveThumbImage: AssetImage('assets/moon.png'),
                  activeTrackColor: Colors.white60,
                  activeColor: Colors.white,
                  value: light,
                  onChanged: (state){
                    setState(() {
                      light = state;
                      light ? img = AssetImage('assets/sun.png') : img = AssetImage('assets/moon.png');
                    });
                  }),],
            ),
            body: SafeArea(
                child: BodyPage(),
                )
            ),
    );
  }
}