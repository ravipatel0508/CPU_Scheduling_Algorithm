import 'package:flutter/material.dart';
import 'package:scheduling_algorithm/appTheme.dart';
import 'package:scheduling_algorithm/colors.dart';

class button extends StatelessWidget {
  button({
    required this.onPressed,
    required this.buttonText,
    required this.isEnabled
  });
  GestureTapCallback onPressed;
  String buttonText = 'hi' ;
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed: null,
        child: Text(buttonText),
        style: ElevatedButton.styleFrom(
          primary: light ? lightButtonColor : darkButtonColor,
          padding: EdgeInsets.only(top: 20,bottom: 20,right: 50,left: 50)
          //minimumSize: Size(20, 10),
        ),
      ),
    );
  }
}
