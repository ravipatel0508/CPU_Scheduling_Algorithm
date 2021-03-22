import 'package:flutter/material.dart';
import 'package:scheduling_algorithm/appTheme.dart';
import 'package:scheduling_algorithm/body_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scheduling Algorithm',
         theme: light ? lightTheme : darkTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Scheduling Algorithms')),
          actions: <Widget>[Switch(activeColor: Colors.grey,value: light, onChanged: (state){setState(() {light = state;});})],
        ),
        body: SafeArea(
            child: BodyPage()
        ),
      )
    );
  }
}