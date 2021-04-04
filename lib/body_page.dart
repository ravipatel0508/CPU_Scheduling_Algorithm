import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Chart/Visulization_Chart.dart';
import 'colorAndTheme/appTheme.dart';
import 'colorAndTheme/colors.dart';
import 'ganttChart/GantChart.dart';

enum DataChoice { First, Second, Third, Own }
const int RR_WINDOW = 3;

class BodyPage extends StatefulWidget {
  @override
  _BodyPageState createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  String dropdownValue = 'FCFS';
  List<String> listItem = ['FCFS', 'SJF', 'SRTF', 'RR', 'TL_FCFS'];
  late int dropDown = 1;

  DataChoice? dataChoice = DataChoice.First;
  TextEditingController? _controller;
  late List<bool> selectedAlgo;
  bool hasResult = false;
  bool error = false;
  String choiceText = "0,5;6,9;6,5;15,10";
  Widget? resWidget;
  FocusNode focus = FocusNode();

  @override
  void initState() {
    _controller = TextEditingController(text: choiceText);
    resWidget = Padding(padding: EdgeInsets.all(50.0));
    focus.addListener(() {
      if (focus.hasFocus) setState(() => dataChoice = DataChoice.Own);
    });
    super.initState();
  }

  @override
  void dispose() {
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                    width: max(700, constraints.maxWidth)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: light ? lightButtonColor : darkButtonColor)
                            ),
                            child: DropdownButton<String>(
                              isDense: true,
                              value: dropdownValue,
                              dropdownColor: light ? lightDropDownColor : darkDropDownColor,
                              elevation: 16,
                              underline: SizedBox(),
                              //style: const TextStyle(color: Colors.white),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                  if (dropdownValue == 'FCFS') {
                                    dropDown = 1;
                                  } else if (dropdownValue == 'SJF') {
                                    dropDown = 2;
                                  } else if(dropdownValue == 'SRTF'){
                                    dropDown = 3;
                                  } else if(dropdownValue == 'RR'){
                                    dropDown = 4;
                                  }else{
                                    dropDown = 5;
                                  }
                                });
                              },
                              items: listItem
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, textAlign: TextAlign.center,),
                                );
                              }).toList(),

                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                                child: Column(
                              children: generateDataInputList(),
                            )),
                            Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 20.0, 0),
                                child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Process table",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Flexible(
                                    child: Builder(
                                      builder: (context) {
                                        List processes;
                                        if (choiceText.isEmpty &&
                                            dataChoice == DataChoice.Own) {
                                          return const TableErrorContainer(
                                            text: "Enter a process array",
                                          );
                                        }
                                        try {
                                          processes =
                                              parseComputationProcesses();
                                          processes[processes.length - 1][1];
                                        } catch (e) {
                                          return const TableErrorContainer(
                                            text: "Faulty process array",
                                          );
                                        }
                                        //return ProcessTable.fromProcessList(processes as List<List<num>>, "Arrival time", "Length", "Completion Time", "TAT",(int index) => "P${index + 1}");
                                        return ProcessTable.fromProcessList(
                                            processes as List<List<num>>,
                                            "Arrival time",
                                            "Length",
                                            (int index) => "P${index + 1}");
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Hero(
                                tag: 'dash',
                                transitionOnUserGestures: true,
                                child: SizedBox(
                                  height: 55,
                                  width: 200,
                                  child: ElevatedButton(
                                    child: Text("Gantt Chart",style: TextStyle(color: light ? Colors.blue : Colors.deepPurpleAccent),),
                                    style: ButtonStyle(
                                      shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(18.0),
                                                side: BorderSide(color: light ? lightButtonColor : darkButtonColor)
                                            )
                                        )
                                    ),
                                    onPressed: () {
                                        if(dropDown == 1) {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>
                                                  FCFS(parseComputationProcesses())));
                                        }else if(dropDown == 2){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>
                                                  SJF(parseComputationProcesses())));
                                        }else if(dropDown == 3){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>
                                                  SRTF(parseComputationProcesses())));
                                        }else if(dropDown == 4){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>
                                                  RR(parseComputationProcesses(),RR_WINDOW)));
                                        }else{
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>
                                                  TL_FCFS(parseComputationProcesses())));
                                        }
                                      },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Hero(
                                tag: 'lol',
                                transitionOnUserGestures: true,
                                child: SizedBox(
                                  height: 55,
                                  width: 200,
                                  child: ElevatedButton(
                                    child: Text("Visualization"),
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(light ? lightButtonColor : darkButtonColor),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(18.0),
                                                side: BorderSide(color: light ? lightButtonColor : darkButtonColor)
                                            )
                                        )
                                    ),
                                    onPressed: () {
                                      if(dropDown == 1) {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                FCFS_Chart(parseComputationProcesses())));
                                      }else if(dropDown == 2){
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                SJF_Chart(parseComputationProcesses())));
                                      }else if(dropDown == 3){
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                SRTF_Chart(parseComputationProcesses())));
                                      } else if(dropDown == 4){
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                RR_Chart(parseComputationProcesses(),RR_WINDOW)));
                                      }else{
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                TL_FCFS_Chart(parseComputationProcesses())));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            )
    );
  }

  List<List<int>> parseComputationProcesses() {
    var rawInput = choiceText.split(";");
    return List.generate(rawInput.length, (i) {
      var str = rawInput[i].split(",");
      return [int.parse(str[0]), int.parse(str[1])];
    });
  }

  String getCpuData(DataChoice? valik) {
    switch (valik) {
      case DataChoice.First:
        return "0,5;6,9;6,5;15,10";
      case DataChoice.Second:
        return "0,2;0,4;12,4;15,5;21,10";
      case DataChoice.Third:
        return "5,6;6,9;11,3;12,7";
      default:
        return "";
    }
  }

  String getData(DataChoice? choice) {
    if (choice == DataChoice.Own) {
      return choiceText;
    }
    return getCpuData(choice);
  }

  List<Widget> generateDataInputList() {
    List<Widget> inputList = List.generate(
      DataChoice.values.length,
      (index) => RadioListTile<DataChoice>(
        title: Text(
            index != 3 ? getData(DataChoice.values[index]) : "Create your own"),
        value: DataChoice.values[index],
        activeColor: light ? Colors.blueAccent : Colors.deepPurple,
        groupValue: dataChoice,
        onChanged: (DataChoice? value) {
          choiceText = getData(DataChoice.values[index]);
          setState(() {
            dataChoice = value;
            if (value != DataChoice.Own) {
              focus.unfocus();
              error = false;
            } else {
              focus.requestFocus();
              choiceText = _controller!.text;
            }
            //for (int i = 0; i < selectedAlgo.length; i++) if (selectedAlgo[i]) runAlgo(i);
          });
        },
      ),
    );
    inputList.add(Flexible(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
        child: TextField(
          cursorColor: Colors.blueAccent,
          focusNode: focus,
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Enter your own process array",
            errorText: error ? "Faulty process array" : null,
          ),
          onChanged: (s) {
            setState(() {
              choiceText = s;
              //for (int i = 0; i < selectedAlgo.length; i++) if (selectedAlgo[i]) runAlgo(i);
            });
          },
        ),
      ),
    ));
    inputList.insert(
        0,
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Choose a process array",
            style: TextStyle(fontSize: 18),
          ),
        ));
    return inputList;
  }
}

class TableErrorContainer extends StatelessWidget {
  const TableErrorContainer({
    Key? key,
    this.text,
  }) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: light ? Colors.blue[100] : Colors.deepPurple[300],
      alignment: Alignment.center,
      child: Text(text!),
    );
  }
}

class TableCellPadded extends StatelessWidget {
  final EdgeInsets? padding;
  final Widget child;
  final TableCellVerticalAlignment? verticalAlignment;

  const TableCellPadded(
      {Key? key, this.padding, required this.child, this.verticalAlignment})
      : super(key: key);

  @override
  TableCell build(BuildContext context) => TableCell(
      verticalAlignment: verticalAlignment,
      child: Padding(padding: padding ?? EdgeInsets.all(5.0), child: child));
}

class ProcessTable extends StatelessWidget {
  final List<TableRow> rows;
  static const TextStyle heading = TextStyle(
    fontWeight: FontWeight.bold,
    //color: Colors.deepPurpleAccent,
  );

  static ProcessTable fromProcessList(List<List<num>> processes,
      String firstProperty, String secondProperty, Function generateID) {
    List<TableRow> rowList = List.generate(
      processes.length,
      (index) {
        List<TableCellPadded> cellList = List.generate(
            processes[index].length,
            (secondIndex) => TableCellPadded(
                child: Text(processes[index][secondIndex].toString())));
        cellList.insert(0, TableCellPadded(child: Text(generateID(index))));
        // cellList.insert(3, TableCellPadded(child: Text("00")));
        // cellList.insert(4, TableCellPadded(child: Text("00")));
        return TableRow(
          children: cellList,
        );
      },
    );
    rowList.insert(
        0,
        TableRow(
          children: [
            const TableCellPadded(
              child: Text(
                "ID",
                style: heading,
              ),
            ),
            TableCellPadded(
              child: Text(
                firstProperty,
                style: heading,
              ),
            ),
            TableCellPadded(
              child: Text(
                secondProperty,
                style: heading,
              ),
            ),
            // TableCellPadded(
            //   child: Text(
            //     thirdProperty,
            //     style: heading,
            //   ),
            // ),
            // TableCellPadded(
            //   child: Text(
            //     fourthProperty,
            //     style: heading,
            //   ),
            // ),
          ],
        ));
    return ProcessTable(rows: rowList);
  }

  const ProcessTable({
    Key? key,
    required this.rows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: light ? lightProcessTable : darkProcessTable,
          width: 3
        ),
        //boxShadow: [light ? BoxShadow(color: Colors.grey[600]!, blurRadius: 7) : BoxShadow(color: Colors.black, blurRadius: 10)]
      ),
      child: Table(
        //border: TableBorder.symmetric(outside: BorderSide(width: 0)),
        children: rows,
      ),
    );
  }
}

class AlgoResult extends StatelessWidget {
  final Widget? resultWidget;
  final StringBuffer log;

  const AlgoResult(this.resultWidget, this.log);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.blue[200],
            boxShadow: [BoxShadow(color: Colors.grey[900]!, blurRadius: 15)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            resultWidget!,
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 50, 0.0, 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.blue[100],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  log.toString(),
                  style: GoogleFonts.sourceCodePro(),
                  maxLines: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
