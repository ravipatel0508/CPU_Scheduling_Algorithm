import 'package:flutter/material.dart';
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
          title: Center(child: Text('Scheduling Algorithms')),
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
        FlatButton(
            onPressed: (){
              setState(() {
                if (light = false) {
                  light = true ;

                }else {
                  light = false;
                }
              }
              );
            },
            padding: EdgeInsets.all(20.0),
            child: Image(image: img))
          ],
        ),
        body: SafeArea(
            child: BodyPage()
        ),
      )
    );
  }
}