import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheduling_algorithm/appTheme.dart';
import 'package:scheduling_algorithm/body_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AssetImage img = new AssetImage('assets/sun.png');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scheduling Algorithm',
         theme: light ? lightTheme : darkTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Scheduling Algorithms', style: GoogleFonts.poppins(),)),
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
              }),
        /*Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(light ? Icons.wb_sunny_outlined : Icons.nights_stay_outlined,color: Colors.amberAccent,),
        ),
            ImageIcon(light ? AssetImage('assets/sun.png') : AssetImage('assets/moon.png'),color: Colors.amberAccent,)*/
          ],
        ),
        body: SafeArea(
            child: BodyPage()
        ),
      )
    );
  }
}