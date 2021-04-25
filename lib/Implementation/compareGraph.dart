
import 'dart:collection';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


late List<List<num>> process;
final List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
  //const Color(0xff02d39a),
];

FCFS_Compare(List<List<num>> processes, int n) {
  print("\n"+processes.toString());

  num totalTime = 0;
  num count = 1;
  num totalWait = 0;

  List<BarChartGroupData> list = [];

  for (var process in processes) {
    if (process[0] > totalTime) {
      int time = process[0] - totalTime as int;
      //chartLineData.add(FlSpot((totalTime + time).toDouble(), (count - 1).toDouble()));
      totalTime += time;
    }

    if (process[0] < totalTime) {
      totalWait += totalTime - process[0];
    }
    //chartLineData.add(FlSpot((totalTime + (process[1] as int)).toDouble(),count.toDouble()));
    totalTime += process[1] as int;
    count += 1;
  }

  list.add(BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
            y: totalWait / processes.length,
            colors: gradientColors.map((color) => color.withOpacity(0.8)).toList()),
      ],
    showingTooltipIndicators: [0]
  ));
  print(processes);
  SJF_Compare(processes, n, list);
  //TL_FCFS_Compare(processes, list);
  // RR_Compare(processes, n, list);
  return ComparePage(list);
}

SJF_Compare(List<List<num>> processes, int n, List<BarChartGroupData> list) {
  num totalTime = 0;
  num count = 0;
  num totalWait = 0;
  var delayProcess = [0, double.infinity, -1];

  List<num> currentProcess = delayProcess;
  num currentWork = 0;
  Queue<List<num>> backlog = new Queue();
  while (true) {
    if (currentProcess[1] == 0) {
      currentWork = 0;
      if (backlog.isNotEmpty) {
        currentProcess = backlog.removeLast();
      } else {
        currentProcess = delayProcess;
      }
    }

    if (count <= processes.length - 1) {
      while (processes[count as int][0] <= totalTime) {
        processes[count].add(count);
        if (processes[count][1] < currentProcess[1]) {
          if (currentWork != 0) {
          }
          currentWork = 0;

          if (currentProcess[2] != -1) backlog.add(currentProcess);
          currentProcess = processes[count];
        } else {
          backlog.add(processes[count]);
        }
        count++;
        if (count > processes.length - 1) break;
      }
    }
    if (currentProcess[2] == -1 && count >= processes.length) {
      break;
    }

    currentProcess[1]--;
    currentWork++;
    totalTime++;
    backlog.forEach((element) => totalWait++);
  }


  list.add(BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
            y: totalWait / processes.length,
            colors: gradientColors.map((color) => color.withOpacity(0.8)).toList()),
      ],
      showingTooltipIndicators: [0]
  ));

  //RR_Compare(processes, n, list);
}

RR_Compare(List<List<num>> processes, int n, List<BarChartGroupData> list) {
  num totalTime = 0;
  num count = 0;
  num totalWait = 0;

  var delayProcess = [0, double.infinity, -1];

  List<num> currentProcess = delayProcess;
  num currentWork = 0;
  Queue<List<num>> backlog = new Queue();
  Queue<List<num>> queue = new Queue();
  while (true) {
    if (count <= processes.length - 1) {
      while (processes[count as int][0] <= totalTime) {
        processes[count].add(count);
        queue.add(processes[count]);
        count++;
        if (count > processes.length - 1) break;
      }
    }

    if (currentProcess[1] == 0 || currentWork == n || (currentProcess[2] == -1 && (backlog.isNotEmpty || queue.isNotEmpty))) {
      if (currentWork != 0)
      if (currentProcess[1] != 0 && currentProcess[2] != -1) {
        backlog.add(currentProcess);
      } else {
      }

      currentWork = 0;
      if (queue.isNotEmpty) {
        currentProcess = queue.removeFirst();
      } else if (backlog.isNotEmpty) {
        currentProcess = backlog.removeFirst();
      } else {
        if (count >= processes.length) break;
        currentProcess = delayProcess;
      }
    }

    currentProcess[1]--;
    currentWork++;
    totalTime++;
    backlog.forEach((element) => totalWait++);
    queue.forEach((element) => totalWait++);
  }

  list.add(BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
            y: totalWait / processes.length,
            colors: gradientColors.map((color) => color.withOpacity(0.8)).toList()),
      ],
      showingTooltipIndicators: [0]
  ));
}

TL_FCFS_Compare(List<List<num>> processes, List<BarChartGroupData> list) {
  num totalTime = 0;
  num count = 0;
  num totalWait = 0;
  List<FlSpot> chartLineData = [];
  chartLineData.add(FlSpot(0, 0));
  var delayProcess = [0, double.infinity, -1];

  List<num> currentProcess = delayProcess;
  num currentWork = 0;
  Queue<List<num>> hQueue = new Queue();
  Queue<List<num>> lQueue = new Queue();
  bool processingLow = false;
  while (true) {
    if (currentProcess[1] == 0) {
      chartLineData.add(FlSpot((totalTime ).toDouble(), (currentProcess[2] != -1 ? currentProcess[2] + 1 : currentProcess[2] + 2).toDouble()));
      print((totalTime - currentWork).toString() + " "+ totalTime.toString());

      currentWork = 0;
      if (hQueue.isNotEmpty) {
        processingLow = false;
        currentProcess = hQueue.removeLast();
      } else if (lQueue.isNotEmpty) {
        processingLow = true;
        currentProcess = lQueue.removeLast();
      } else {
        processingLow = true;
        currentProcess = delayProcess;
      }
    }

    if (count <= processes.length - 1) {
      while (processes[count as int][0] <= totalTime) {
        processes[count].add(count);
        if ((processes[count][1] <= 6 && processingLow) || currentProcess[2] == -1) {
          if (currentWork != 0) {
            chartLineData.add(FlSpot((totalTime).toDouble(), (currentProcess[2] != -1 ? currentProcess[2] + 1 : currentProcess[2] + 2).toDouble()));
          }
          currentWork = 0;

          if (currentProcess[2] != -1) {
            if (processingLow) {
              lQueue.add(currentProcess);
            } else {
              hQueue.add(currentProcess);
            }
          }

          currentProcess = processes[count];
        } else if (processes[count][1] <= 6) {
          hQueue.add(processes[count]);
        } else {
          lQueue.add(processes[count]);
        }
        count++;
        if (count > processes.length - 1) break;
      }
    }

    if (currentProcess[2] == -1 && count >= processes.length) {
      break;
    }

    currentProcess[1]--;
    currentWork++;
    totalTime++;
    hQueue.forEach((element) => totalWait++);
    lQueue.forEach((element) => totalWait++);

  }


}

/*Widget SRTF_Chart(List<List<int>> processes) {
  StringBuffer log = new StringBuffer();

  List<FlSpot> chartLineData = [];
  chartLineData.add(FlSpot(0, 0));

  List<List<int>> proc = processes;
  //List<List<int>> proc = [[0, 5], [6, 9], [6, 5], [15,10]];
  //List<List<int>> proc = [[0,2],[0,4],[12,4],[15,5],[21,10]];

  List<double> wT = [0, 0, 0, 0, 0];
  List<double> tT = [0, 0, 0, 0, 0];
  int n = proc.length - 1;
  List<int> start = [];
  List<int> end = [];
  List<int> text = [];

  //Calculation of Total Time and Initialization of Time Chart array
  int total_time = 0;

  for (int i = 0; i <= n; i++) {
    total_time += proc[i][1];
  }

  List<int> time_chart = [];

  for(int i = 0; i < total_time; i++)
  {
    //Selection of shortest process which has arrived
    int sel_proc = 0;
    int min = 99999;
    for(int j = 1; j <= n; j++)
    {
      if(proc[j][0] <= i)//Condition to check if Process has arrived
          {
        if(proc[j][1] < min && proc[j][1] != 0)
        {
          min = proc[j][1].toInt();
          sel_proc = j;
        }
      }
    }

    //Assign selected process to current time in the Chart
    time_chart.insert(i, sel_proc);

    //Decrement Remaining Time of selected process by 1 since it has been assigned the CPU for 1 unit of time
    proc[sel_proc][1]--;

    //WT and TT Calculation
    for(int j = 1; j <= n; j++)
    {
      if(proc[j][0] <= i)
      {
        if(proc[j][1] != 0)
        {
          //If process has arrived and it has not already completed execution its TT is incremented by 1
          tT[j]++;
          if(j != sel_proc)//If the process has not been currently assigned the CPU and has arrived its WT is incremented by 1
              {
            wT[j]++;
          }
        }
        else if(j == sel_proc)//This is a special case in which the process has been assigned CPU and has completed its execution

          tT[j]++;
      }
    }

    //Printing the Time Chart
    if(i != 0)
    {
      if(sel_proc != time_chart[i - 1]) //If the CPU has been assigned to a different Process we need to print the current value of time and the name of//the new Process
          {
        start.add(i);
        end.add(i);
        log.write("--" + i.toString() + "--P" + (sel_proc - 1).toString());
        text.add(sel_proc);
      }
    }
    else//If the current time is 0 i.e the printing has just started we need to print the name of the First selected Process
        {
      log.write(i.toString() + "--P" + (sel_proc - 1).toString());
      start.add(i);
      end.add(i);
      text.add(sel_proc);
    }
    if(i == total_time - 1)//All the process names have been printed now we have to print the time at which execution ends
        {
      log.write("--" + i.toString());
      start.add(i);
      end.add(i);
      //text.add("P" + i.toString());
    }
  }
  log.writeln();
  log.writeln();

  //Printing the WT and TT for each Process
  log.writeln("P   WT   TT ");
  for(int i = 1; i <= n; i++)
  {
    log.write(i.toString()+ "   "+ wT[i].toString()+ "   "+ tT[i].toString());
    log.writeln();
  }

  log.writeln();

  //Printing the average WT & TT
  double WT = 0,TT = 0;
  for(int i = 1; i <= n; i++)
  {
    WT += wT[i];
    TT += tT[i];
  }
  WT /= n;
  TT /= n;
  log.writeln("The Average WT is: " + WT.toString() + "ms");
  log.writeln("The Average TT is: " + TT.toString() + "ms");


  //start = end;
  start.removeLast();
  end.removeAt(0);
  for (int i = 0; i < start.length; i++) {
    chartLineData.add(FlSpot(end[i].toDouble(), text[i].toDouble()));
  }
  return lineData(chartLineData, total_time - 1, proc.length - 1, WT);
}*/

class ComparePage extends StatefulWidget {
  final List<BarChartGroupData> list;

  ComparePage(this.list);

  @override
  State<StatefulWidget> createState() => ComparePageState();
}

class ComparePageState extends State<ComparePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xff020227),
      appBar: AppBar(
        backgroundColor: Color(0xff020227),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: AspectRatio(
          aspectRatio: 1,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: const Color(0xff020227),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        makeTransactionsIcon(),
                        const SizedBox(
                          width: 38,
                        ),
                        const Text(
                          'Comparision',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'state',
                          style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                        ),
                      ],
                    ),
                    Expanded(
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 20,
                          barTouchData: BarTouchData(
                            enabled: false,
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: Colors.transparent,
                              tooltipPadding: const EdgeInsets.all(0),
                              tooltipMargin: 8,
                              getTooltipItem: (
                                  BarChartGroupData group,
                                  int groupIndex,
                                  BarChartRodData rod,
                                  int rodIndex,
                                  ) {
                                return BarTooltipItem(
                                  rod.y.round().toString(),
                                  TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (value) => const TextStyle(
                                  color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                              margin: 20,
                              getTitles: (double value) {
                                switch (value.toInt()) {
                                  case 0:
                                    return 'FCFS';
                                  case 1:
                                    return 'SJF';
                                  case 2:
                                    return 'SRTF';
                                  case 3:
                                    return 'RR';
                                  case 4:
                                    return 'TL_FCFS';
                                  default:
                                    return '';
                                }
                              },
                            ),
                            leftTitles: SideTitles(showTitles: false),
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          barGroups: widget.list
                          /*[
                            BarChartGroupData(
                              x: 0,
                              barRods: [
                                BarChartRodData(y: 8, colors: gradientColors.map((color) => color.withOpacity(0.8)).toList())
                              ],
                              showingTooltipIndicators: [0],
                            ),
                            BarChartGroupData(
                              x: 1,
                              barRods: [
                                BarChartRodData(y: 10, colors: gradientColors.map((color) => color.withOpacity(0.8)).toList())
                              ],
                              showingTooltipIndicators: [0],
                            ),
                            BarChartGroupData(
                              x: 2,
                              barRods: [
                                BarChartRodData(y: 14, colors: gradientColors.map((color) => color.withOpacity(0.8)).toList())
                              ],
                              showingTooltipIndicators: [0],
                            ),
                            BarChartGroupData(
                              x: 3,
                              barRods: [
                                BarChartRodData(y: 15, colors: gradientColors.map((color) => color.withOpacity(0.8)).toList())
                              ],
                              showingTooltipIndicators: [0],
                            ),
                            BarChartGroupData(
                              x: 4,
                              barRods: [
                                BarChartRodData(y: 12, colors: gradientColors.map((color) => color.withOpacity(0.8)).toList())
                              ],
                              showingTooltipIndicators: [0],
                            ),
                          ],*/
                        ),
                      ),
                    )
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget makeTransactionsIcon() {
    const double width = 4.5;
    const double space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}