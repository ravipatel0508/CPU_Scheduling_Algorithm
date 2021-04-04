import 'package:flutter/material.dart';

class AAAA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blueGrey[50],
      child: Center(
        child: Text(
          'Dashboard',
          style: Theme.of(context).textTheme.headline3,
          // overflow: TextOverflow.visible,
          //softWrap: false,
        ),
      ),
    );
  }
}
