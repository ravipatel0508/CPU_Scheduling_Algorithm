import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scheduling_algorithm/algoTheory.dart';

import 'colorAndTheme/appTheme.dart';
import 'colorAndTheme/colors.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  String dropdownValue = 'FCFS';
  List<String> listItem = ['FCFS', 'SJF', 'SRTF', 'RR', 'TL_FCFS'];
  String text = fcfsString;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                    width: max(700, constraints.maxWidth)),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, top: 10, right: 8),
                      child: Text(
                        "Information",
                        style:
                            TextStyle(color: Colors.blueGrey, fontSize: 35),
                      ),
                    ),
                    Divider(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: darkButtonColor)),
                            child: DropdownButton<String>(
                              isDense: true,
                              value: dropdownValue,
                              dropdownColor: Colors.blueGrey,
                              elevation: 16,
                              underline: SizedBox(),
                              //style: const TextStyle(color: Colors.white),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                  if (dropdownValue == 'FCFS') {
                                    text = fcfsString;
                                  } else if (dropdownValue == 'SJF') {
                                    text = sjfString;
                                  } else if (dropdownValue == 'SRTF') {
                                    text = srtfString;
                                  } else if (dropdownValue == 'RR') {
                                    text = rrString;
                                  } else {
                                    text = tlfcfsString;
                                  }
                                });
                              },
                              items: listItem.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: light ? Colors.black : Colors.white
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ]),
                    Row(
                      children: [
                        Container(
                          child: Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(text,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 17
                              ),),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
