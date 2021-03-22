
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheduling_algorithm/button.dart';
import 'package:scheduling_algorithm/gantChart.dart';

import 'appTheme.dart';
import 'colors.dart';

class BodyPage extends StatefulWidget {
  @override
  _BodyPageState createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  String dropdownValue = 'FCFS';
  List<String> listItem = ['FCFS', 'SJF', 'SRTN'];
  List<TableRow> tableCellUi = [];
  int count = 0;

  String complitionTime = '0';


  double _avg_tat = 0,
      _avg_wt = 0;
  var counter = 0;
  List<DataRow> rowList = [];
  List<List<int>> data = [];
  List<List<String>> datas = [];
  List<List<int>> cardv = [];
  List<List<String>> cardvs = [];
  List<List<bool>> readyq = [];
  List<String> Na = [], Re = [], Ru = [], Te = [];
  List<List<Widget>> disdata = [], disNum = [];

  final arrivalTime = TextEditingController();
  List<int> arrivalList = [2, 1, 4];
  List<int> bustList = [2,5,12];
  final bustTime = TextEditingController();
  List<List<int>> DATATA = [[1, 2], [2,4], [3,6], [44,2], [12,5]];

  // List<List<num>> inputData() {
  //   var rawInput = getData(dataChoice).split(";");
  //   return List.generate(rawInput.length, (i) {
  //     var str = rawInput[i].split(",");
  //     return [int.parse(str[0]), int.parse(str[1])];
  //   });
  // }

  late final int start = 3;
  late final int end = 6;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child:
            Column(
              children: [
                Container(
                  width: 200,
                  child: DropdownButton<String>(
                    isDense: true,
                    value: dropdownValue,
                    dropdownColor: light ? lightButtonColor : darkButtonColor,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    //style: const TextStyle(color: Colors.white),
                    underline: Container(height: 2,
                      color: light ? lightButtonColor : darkButtonColor,),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        if (dropdownValue == 'FCFS') {
                          FCFS;
                        }
                        else if (dropdownValue == 'SJF') {}
                        else {}
                      });
                    },
                    items: listItem.map<DropdownMenuItem<String>>((
                        String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 200.0),
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Process  ',),
                            numeric: false),
                        DataColumn(
                            label: Text('AT',),
                            numeric: true),
                        DataColumn(
                            label: Text('BT',),
                            numeric: true),
                        DataColumn(
                            label: Text('CT',),
                            numeric: true),
                        DataColumn(
                            label: Text('TAT',),
                            numeric: true),
                        DataColumn(
                            label: Text('WT',),
                            numeric: true),
                      ],
                      rows: rowList,
                    ),
                  ),
                ),
               // tableUI()
              ],
            ),
          ),
          Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
              Column(children: [
                button(onPressed: addRow, buttonText: 'Add Process', isEnabled: true,),
                //button(onPressed: () => {FCFS([[0],[1]])}, buttonText: 'Gantt Chart', isEnabled: true),
                button(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => FCFS(DATATA,arrivalList,bustList)));}, buttonText: 'Gantt Chart', isEnabled: true,),
                button(onPressed: () {print("Average WT = 0.00");}, buttonText: 'Average WT = ' + _avg_wt.toStringAsFixed(2), isEnabled: false,),
                /*Column(children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Flexible(
                        flex: end - start,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border(
                              right: BorderSide(),
                              left: BorderSide(color: Colors.black.withAlpha(start == 0 ? 255 : 0)),
                            ),
                          ),
                          child: Stack(
                            clipBehavior: Clip.hardEdge,
                            children: [
                              Center(
                                child: Text(
                                  'text',
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: -20,
                                child: Text(
                                  end.toString(),
                                  style: GoogleFonts.sourceCodePro(),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                bottom: -20,
                                child: Text(
                                  start == 0 ? '0' : '',
                                  style: GoogleFonts.sourceCodePro(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                        Flexible(
                          flex: end - start,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border(
                                right: BorderSide(),
                                left: BorderSide(color: Colors.black.withAlpha(start == 0 ? 255 : 0)),
                              ),
                            ),
                            child: Stack(
                              clipBehavior: Clip.hardEdge,
                              children: [
                                Center(
                                  child: Text(
                                    'text',
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: -20,
                                  child: Text(
                                    end.toString(),
                                    style: GoogleFonts.sourceCodePro(),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  bottom: -20,
                                  child: Text(
                                    start == 0 ? '0' : '',
                                    style: GoogleFonts.sourceCodePro(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],)*/
              ],),
              Column(children: [
                button(onPressed: deleteRow, buttonText: 'Delete Process', isEnabled: true,),
                button(onPressed: Gant, buttonText: 'Visualization', isEnabled: true,),
                button(onPressed: () {print("Average TAT = 0.00");}, buttonText: 'Average TAT = ' + _avg_tat.toStringAsFixed(2), isEnabled: false,),
              ],),
            ],
            ),
          ),
        ],
      ),
    );
  }



  Widget tableUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        //border: TableBorder.all(color: Colors.black),
        children: tableCellUi,
      ),
    );
}

  void Gant() {
    cardv.clear();
    cardvs.clear();
    readyq.clear();

    int cal = 0, st = 0, tt = 0;
    List<bool> vis;
    vis = new List<bool>.filled(counter, false);
    while (cal != counter) {
      readyq.add(List.filled(counter, false));
      var mn = 100, loc = 0;
      for (var i = 0; i < counter; ++i) {
        if (data[i][0] < mn && !vis[i]) {
          mn = data[i][0];
          loc = i;
        }
        if (!vis[i] && st >= data[i][0]) {
          readyq[tt][i] = true;
        }
      }
      cardv.add([0, 0, 0, 0]);
      cardvs.add(['0', '0', '0', '0']);
      vis[loc] = true;
      cal++;
      cardv[tt][0] = loc;
      cardv[tt][1] = max(data[loc][0], st);
      data[loc][2] = max(data[loc][0], st) + data[loc][1];
      st = data[loc][2];
      cardv[tt][2] = data[loc][2];
      cardv[tt][3] = 1;
      data[loc][3] = data[loc][2] - data[loc][0];
      data[loc][4] = data[loc][3] - data[loc][1];
      for (int i = 0; i < 5; ++i) datas[loc][i] = data[loc][i].toString();
      for (int i = 0; i < 4; ++i) cardvs[tt][i] = cardv[tt][i].toString();
      tt++;
    }
  }

  void addRow(){
  setState(() {
    var t = counter;
    counter++;
    data.add([0, 0, 0, 0, 0]);

    datas.add(['0', '0', '0', '0', '0']);

    rowList.add(DataRow(cells: <DataCell>[
      DataCell(Text('P' + (counter - 1).toString(),)),
      DataCell(TextField(
        //controller: arrivalTime,
        maxLines: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        // style: TextStyle(color: Colors.white),
        onChanged: (val) {
          setState(() {
            datas[t][0] = val;
            data[t][0] = int.parse(val);
            calculate();
          });
        },
      )),
      DataCell(TextField(
        //controller: bustTime,
        maxLines: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        // style: TextStyle(color: Colors.white),
        onChanged: (val) {
          datas[t][1] = val;
          data[t][1] = int.parse(val);
          setState(() {
            calculate();
          });
        },
      )),
      DataCell(Text(datas[t][2],
      )),
      DataCell(Text(datas[t][3],
      )),
      DataCell(Text(datas[t][4],
      )),
    ]));
  });
}

  void deleteRow(){
    setState(() {
      counter--;
      rowList.removeLast();
      data.removeLast();
      datas.removeLast();
      calculate();
    });
  }

  void calculate() {
    int cal = 0, st = 0;
    List<bool> vis;
    vis = new List<bool>.filled(counter, false);

    while (cal != counter) {
      var mn = 100, loc = 0;

      for (var i = 0; i < counter; ++i) {
        if (data[i][0] < mn && !vis[i]) {
          mn = data[i][0];
          loc = i;
        }
      }

      vis[loc] = true;
      cal++;
      data[loc][2] = max(data[loc][0], st) + data[loc][1];
      st = data[loc][2];
      data[loc][3] = data[loc][2] - data[loc][0];
      data[loc][4] = data[loc][3] - data[loc][1];

      for (int i = 0; i < 5; ++i) datas[loc][i] = data[loc][i].toString();
      int _sum = 0;

      for (int i = 0; i < counter; ++i) _sum += data[i][3];
      _avg_tat = _sum / counter;
      _sum = 0;

      for (int i = 0; i < counter; ++i) _sum += data[i][4];
      _avg_wt = _sum / counter;
      int t = loc;

      rowList[loc] = DataRow(
          cells: <DataCell>[
            DataCell(Text('P' + t.toString(),)),
            DataCell(TextField(
              maxLines: 1,
              //textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (val) {
                setState(() {
                  datas[t][0] = val;
                  data[t][0] = int.parse(val);
                  calculate();
                });
              },
            )),
            DataCell(TextField(
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (val) {
                datas[t][1] = val;
                data[t][1] = int.parse(val);
                setState(() {
                  calculate();
                });
              },
            )),
            DataCell(Text(datas[t][2],)),
            DataCell(Text(datas[t][3],)),
            DataCell(Text(datas[t][4],)),
      ]);
    }
  }

}


// ignore: camel_case_types
Widget processBar() {
  late final int start =1;
  late final int end =2;

    return Flexible(
        flex: end - start,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border(
              right: BorderSide(),
              left: BorderSide(color: Colors.black.withAlpha(start == 0 ? 255 : 0)),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Center(
                child: Text(
                  'text',
                ),
              ),
              Positioned(
                right: 0,
                bottom: -20,
                child: Text(
                  end.toString(),
                  style: GoogleFonts.sourceCodePro(),
                ),
              ),
              Positioned(
                left: 0,
                bottom: -20,
                child: Text(
                  start == 0 ? '0' : '',
                  style: GoogleFonts.sourceCodePro(),
                ),
              ),
            ],
          ),
        ),
      );
}
