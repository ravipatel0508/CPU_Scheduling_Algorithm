// import 'dart:math';
//Container(margin: EdgeInsets.fromLTRB(0.0, 50, 0.0, 0.0),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 color: Colors.blue[100],
//               ),
//
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(gg.toString()),
//               ),
//             )
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart ';
//
// class FCFS extends StatefulWidget {
//   @override
//   _FCFSState createState() => _FCFSState();
// }
//
// class _FCFSState extends State<FCFS> {
//   var counter = 0;
//   double _avg_tat = 0, _avg_wt = 0;
//
//   List<DataRow> rowList = [];
//   List<List<int>> data = [];
//   List<List<String>> datas = [];
//   List<List<int>> cardv = [];
//   List<List<String>> cardvs = [];
//   List<List<bool>> readyq = [];
//   List<String> Na = [], Re = [], Ru = [], Te = [];
//   List<List<Widget>> disdata = [], disNum = [];
//
//   void _viz() {
//     int fct = 0;
//     for (int i = 0; i < counter; ++i) {
//       fct = max(fct, data[i][2]);
//     }
//     List<int> _ddata;
//     _ddata = new List<int>.filled(fct + 1, -1);
//     for (int i = 0; i < counter; ++i) {
//       int start = data[i][0] + data[i][4];
//       for (int j = start + 1; j <= data[i][2]; ++j) {
//         _ddata[j] = i;
//       }
//     }
//     disdata.clear();
//     disdata.add([]);
//     disNum.clear();
//     disNum.add([]);
//     for (int i = 1; i <= fct; ++i) {
//       disdata.add([]);
//       disNum.add(
//         [
//           Container(
//             height: 30,
//             child: Text(
//               '0',
//               style: TextStyle( fontSize: 25),
//             ),
//           ),
//         ],
//       );
//       for (int j = 1; j <= i; ++j) {
//         String temp = 'P' + _ddata[j].toString();
//         if (_ddata[j] == -1) temp = ' ';
//         if (j + 1 <= i && _ddata[j] == _ddata[j + 1]) continue;
//         disNum[i].add(
//           Container(height: 70),
//         );
//         disNum[i].add(
//           Container(
//             height: 30,
//             child: Text(
//               j.toString(),
//               style: TextStyle( fontSize: 25),
//             ),
//           ),
//         );
//         if (j == i && j + 1 <= fct && _ddata[j] == _ddata[j + 1]) {
//           disdata[i].add(
//             Container(
//               decoration: BoxDecoration(
//                 border: Border(
//                   left: BorderSide(color: Colors.blue),
//                   right: BorderSide(color: Colors.blue),
//                   top: BorderSide(color: Colors.blue),
//                 ),
//               ), //all(color: redColor)),
//               width: 100,
//               height: 100,
//               child: Center(
//                 child: Text(
//                   temp,
//                   style: TextStyle( fontSize: 25),
//                 ),
//               ),
//             ),
//           );
//           continue;
//         }
//         disdata[i].add(
//           Container(
//             decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
//             width: 100,
//             height: 100,
//             child: Center(
//               child: Text(
//                 temp,
//                 style: TextStyle( fontSize: 25),
//               ),
//             ),
//           ),
//         );
//       }
//     }
//     Na.clear();
//     Re.clear();
//     Ru.clear();
//     Te.clear();
//     for (int i = 0; i <= fct; ++i) {
//       String tempNa = '', tempRe = '', tempTe = '', tempRu = '';
//       for (int j = 0; j < counter; ++j) {
//         if (data[j][0] > i) {
//           if (tempNa.isEmpty)
//             tempNa += 'P' + j.toString();
//           else
//             tempNa += ', P' + j.toString();
//         } else if (data[j][4] + data[j][0] >= i) {
//           if (tempRe.isEmpty)
//             tempRe += 'P' + j.toString();
//           else
//             tempRe += ', P' + j.toString();
//         } else if (data[j][2] <= i) {
//           if (tempTe.isEmpty)
//             tempTe += 'P' + j.toString();
//           else
//             tempTe += ', P' + j.toString();
//         } else
//           tempRu += 'P' + j.toString();
//       }
//       Na.add(tempNa);
//       Re.add(tempRe);
//       Te.add(tempTe);
//       Ru.add(tempRu);
//     }
//
//     // view.TakeData('FCFS', Na, Re, Ru, Te, fct, disdata, disNum);
//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(builder: (context) => view()),
//     // );
//   }
//
//   void Gant() {
//     cardv.clear();
//     cardvs.clear();
//     readyq.clear();
//
//     int cal = 0, st = 0, _tt = 0;
//     List<bool> vis;
//     vis = new List<bool>.filled(counter, false);
//     while (cal != counter) {
//       readyq.add(List.filled(counter, false));
//       var mn = 100, loc = 0;
//       for (var i = 0; i < counter; ++i) {
//         if (data[i][0] < mn && !vis[i]) {
//           mn = data[i][0];
//           loc = i;
//         }
//         if (!vis[i] && st >= data[i][0]) {
//           readyq[_tt][i] = true;
//         }
//       }
//       cardv.add([0, 0, 0, 0]);
//       cardvs.add(['0', '0', '0', '0']);
//       vis[loc] = true;
//       cal++;
//       cardv[_tt][0] = loc;
//       cardv[_tt][1] = max(data[loc][0], st);
//       data[loc][2] = max(data[loc][0], st) + data[loc][1];
//       st = data[loc][2];
//       cardv[_tt][2] = data[loc][2];
//       cardv[_tt][3] = 1;
//       data[loc][3] = data[loc][2] - data[loc][0];
//       data[loc][4] = data[loc][3] - data[loc][1];
//       for (int i = 0; i < 5; ++i) datas[loc][i] = data[loc][i].toString();
//       for (int i = 0; i < 4; ++i) cardvs[_tt][i] = cardv[_tt][i].toString();
//       _tt++;
//     }
//   }
//
//    void calculate() {
//     int cal = 0, st = 0;
//     List<bool> vis;
//     vis = new List<bool>.filled(counter, false);
//     while (cal != counter) {
//       var mn = 100, loc = 0;
//       for (var i = 0; i < counter; ++i) {
//         if (data[i][0] < mn && !vis[i]) {
//           mn = data[i][0];
//           loc = i;
//         }
//       }
//       vis[loc] = true;
//       cal++;
//       data[loc][2] = max(data[loc][0], st) + data[loc][1];
//       st = data[loc][2];
//       data[loc][3] = data[loc][2] - data[loc][0];
//       data[loc][4] = data[loc][3] - data[loc][1];
//       for (int i = 0; i < 5; ++i) datas[loc][i] = data[loc][i].toString();
//       int _sum = 0;
//       for (int i = 0; i < counter; ++i) _sum += data[i][3];
//       _avg_tat = _sum / counter;
//       _sum = 0;
//       for (int i = 0; i < counter; ++i) _sum += data[i][4];
//       _avg_wt = _sum / counter;
//       int t = loc;
//       rowList[loc] = DataRow(cells: <DataCell>[
//         DataCell(
//             Text('P' + t.toString(),
//               //style: TextStyle(color: Colors.white)
//             )
//         ),
//         DataCell(TextField(
//           maxLines: 1,
//           textAlign: TextAlign.center,
//           keyboardType: TextInputType.number,
//           //style: TextStyle(color: Colors.white),
//           onChanged: (val) {
//             setState(() {
//               datas[t][0] = val;
//               data[t][0] = int.parse(val);
//               calculate();
//             });
//           },
//         )),
//         DataCell(TextField(
//           maxLines: 1,
//           textAlign: TextAlign.center,
//           keyboardType: TextInputType.number,
//           //style: TextStyle(color: Colors.white),
//           onChanged: (val) {
//             datas[t][1] = val;
//             data[t][1] = int.parse(val);
//             setState(() {
//               calculate();
//             });
//           },
//         )),
//         DataCell(Text(datas[t][2], //style: TextStyle(color: Colors.white)
//         )),
//         DataCell(Text(datas[t][3], //style: TextStyle(color: Colors.white)
//         )),
//         DataCell(Text(datas[t][4], //style: TextStyle(color: Colors.white)
//         )),
//       ]);
//     }
//   }
//
//    _addrow() {
//     setState(() {
//       var t = counter;
//       counter++;
//       data.add([0, 0, 0, 0, 0]);
//
//       datas.add(['0', '0', '0', '0', '0']);
//
//       rowList.add(DataRow(cells: <DataCell>[
//         DataCell(Text('P' + (counter - 1).toString(),
//           //  style: TextStyle(color: Colors.white)
//         )),
//         DataCell(TextField(
//           maxLines: 1,
//           textAlign: TextAlign.center,
//           keyboardType: TextInputType.number,
//           // style: TextStyle(color: Colors.white),
//           onChanged: (val) {
//             setState(() {
//               datas[t][0] = val;
//               data[t][0] = int.parse(val);
//               calculate();
//             });
//           },
//         )),
//         DataCell(TextField(
//           maxLines: 1,
//           textAlign: TextAlign.center,
//           keyboardType: TextInputType.number,
//           // style: TextStyle(color: Colors.white),
//           onChanged: (val) {
//             datas[t][1] = val;
//             data[t][1] = int.parse(val);
//             setState(() {
//               calculate();
//             });
//           },
//         )),
//         DataCell(Text(datas[t][2],// style: TextStyle(color: Colors.white)
//         )),
//         DataCell(Text(datas[t][3],// style: TextStyle(color: Colors.white)
//         )),
//         DataCell(Text(datas[t][4],// style: TextStyle(color: Colors.white)
//         )),
//       ]));
//     });
//   }
//
//
//   var f = true;
//   @override
//   Widget build(BuildContext context) {
//     if (f) {
//       _addrow();
//       f = false;
//     }
//
//     return Container();
//   }
// }
