import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduling_algorithm/GantChart.dart';







class SRTF_Body extends StatelessWidget {
  StringBuffer log;

  SRTF_Body(this.log);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Center(
        child: Container(
          child: Text(log.toString()),
        ),
      ),
    );
  }
}
