import 'package:flutter/material.dart';
import 'body_page.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Scheduling Algorithms')),
      ),
      body: SafeArea(
          child: BodyPage()
      ),
    );
  }
}