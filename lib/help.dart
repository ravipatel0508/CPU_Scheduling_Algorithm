import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blueGrey[50],
      child: Center(
        child: Text(
          'Help',
          style: Theme.of(context).textTheme.headline3,
          // overflow: TextOverflow.visible,
          //softWrap: false,
        ),
      ),
    );
  }
}
