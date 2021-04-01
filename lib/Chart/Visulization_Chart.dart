import 'dart:collection';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';



Widget FCFS_Chart(List<List<num>> processes) {
  num totalTime = 0;
  num count = 1;
  num totalWait = 0;

  List<FlSpot> chartLineData = [];
  chartLineData.add(FlSpot(0, 0));

  for (var process in processes) {
    if (process[0] > totalTime) {
      int time = process[0] - totalTime as int;
      chartLineData.add(FlSpot((totalTime + time).toDouble(), (count - 1).toDouble()));
      totalTime += time;
    }

    if (process[0] < totalTime) {
      totalWait += totalTime - process[0];
    }
    chartLineData.add(FlSpot((totalTime + (process[1] as int)).toDouble(),count.toDouble()));
    totalTime += process[1] as int;
    count += 1;
  }

  return lineData(chartLineData, totalTime, processes.length);
}

Widget SJF_Chart(List<List<num>> processes) {
  num totalTime = 0;
  num count = 0;
  num totalWait = 0;
  List<FlSpot> chartLineData = [];
  chartLineData.add(FlSpot(0, 0));
  //List<CpuProcessBar> resList = [];
  //List<Color> colors = List.generate(processes.length, (index) => light ? Color((Random(index).nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.1) : Color((Random(index).nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2));
  var delayProcess = [0, double.infinity, -1];

  List<num> currentProcess = delayProcess;
  num currentWork = 0;
  Queue<List<num>> backlog = new Queue();
  while (true) {
    if (currentProcess[1] == 0) {
      chartLineData.add(FlSpot((totalTime).toDouble(), currentProcess[2] != -1 ? currentProcess[2] + 1 : (currentProcess[2]+3).toDouble()));
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
            chartLineData.add(FlSpot(totalTime.toDouble(), currentProcess[2] != -1 ? currentProcess[2] + 1 : (currentProcess[2]+3).toDouble()));
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

  return lineData(chartLineData, totalTime, processes.length);
}

Widget RR_Chart(List<List<num>> processes, int n) {
  num totalTime = 0;
  num count = 0;
  num totalWait = 0;
  List<FlSpot> chartLineData = [];
  chartLineData.add(FlSpot(0, 0));
  //List<CpuProcessBar> resList = [];
  //List<Color> colors = List.generate(processes.length, (index) => light ? Color((Random(index).nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.1) : Color((Random(index).nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2));
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
        chartLineData.add(FlSpot(totalTime.toDouble(), currentProcess[2] != -1 ? (currentProcess[2] + 1).toDouble() : (currentProcess[2]+2).toDouble()));
       // resList.add(CpuProcessBar(totalTime - currentWork as int, totalTime as int, currentProcess[2] != -1 ? "P${currentProcess[2] + 1}" : "", currentProcess[2] != -1 ? colors[currentProcess[2] as int] : Colors.grey));
      if (currentProcess[1] != 0 && currentProcess[2] != -1) {
        backlog.add(currentProcess);
      } else {
        //log.write("\n   Finished P${currentProcess[2] + 1}");
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
  return lineData(chartLineData, totalTime, processes.length);
}

Widget TL_FCFS_Chart(List<List<num>> processes) {
  num totalTime = 0;
  num count = 0;
  num totalWait = 0;
  List<FlSpot> chartLineData = [];
  chartLineData.add(FlSpot(0, 0));
  //List<Color> colors = List.generate(processes.length, (index) => Color((Random(index).nextDouble() * 0xFFFFFF).toInt()).withOpacity(.2));
  var delayProcess = [0, double.infinity, -1];

  List<num> currentProcess = delayProcess;
  num currentWork = 0;
  Queue<List<num>> hQueue = new Queue();
  Queue<List<num>> lQueue = new Queue();
  bool processingLow = false;
  while (true) {
    if (currentProcess[1] == 0) {
      //resList.add(CpuProcessBar(totalTime - currentWork as int, totalTime as int, currentProcess[2] != -1 ? "P${currentProcess[2] + 1}" : "", currentProcess[2] != -1 ? colors[currentProcess[2] as int] : Colors.cyan[100]!));
      chartLineData.add(FlSpot((totalTime ).toDouble(), (currentProcess[2] != -1 ? currentProcess[2] + 1 : currentProcess[2] + 2).toDouble()));
      print((totalTime - currentWork).toString() + " "+ totalTime.toString());

      currentWork = 0;
      if (hQueue.isNotEmpty) {
        processingLow = false;
        currentProcess = hQueue.removeLast();
        //log.write("\n   Starting P${currentProcess[2] + 1} from high-priority queue");
      } else if (lQueue.isNotEmpty) {
        processingLow = true;
        currentProcess = lQueue.removeLast();
        //log.write("\n   Starting P${currentProcess[2] + 1} from low-priority queue");
      } else {
        processingLow = true;
        //log.write("\n   Starting delay task");
        currentProcess = delayProcess;
      }
    }

    if (count <= processes.length - 1) {
      while (processes[count as int][0] <= totalTime) {
        //log.write("\nQueueing process P${count + 1} ${processes[count]} at time $totalTime");
        processes[count].add(count);
        if ((processes[count][1] <= 6 && processingLow) || currentProcess[2] == -1) {
          if (currentWork != 0) {
           // resList.add(CpuProcessBar(totalTime - currentWork as int, totalTime as int, currentProcess[2] != -1 ? "P${currentProcess[2] + 1}" : "", currentProcess[2] != -1 ? colors[currentProcess[2] as int] : Colors.cyan[100]!));
            chartLineData.add(FlSpot((totalTime).toDouble(), (currentProcess[2] != -1 ? currentProcess[2] + 1 : currentProcess[2] + 2).toDouble()));
          }
          //log.write("\n   New process is higher priority than P${currentProcess[2] + 1}, saving work ($currentWork) in bar and starting P${count + 1}");
          currentWork = 0;

          if (currentProcess[2] != -1) {
            if (processingLow) {
              //log.write("\n   Adding P${count + 1} back to low-priority queue");
              lQueue.add(currentProcess);
            } else {
              //log.write("\n   Adding P${count + 1} back to high-priority queue");
              hQueue.add(currentProcess);
            }
          }

          currentProcess = processes[count];
        } else if (processes[count][1] <= 6) {
          //log.write("\n   Adding P${count + 1} to high-priority queue");
          hQueue.add(processes[count]);
        } else {
          //log.write("\n   Adding P${count + 1} to low-priority queue");
          lQueue.add(processes[count]);
        }
        count++;
        if (count > processes.length - 1) break;
      }
    }

    if (currentProcess[2] == -1 && count >= processes.length) {
      //log.write("\nFinished TL_FCFS");
      break;
    }

    currentProcess[1]--;
    currentWork++;
    totalTime++;
    hQueue.forEach((element) => totalWait++);
    lQueue.forEach((element) => totalWait++);
    //log.write("\n#######P${currentProcess[2] + 1} $currentProcess, currentWork: $currentWork, time: $totalTime, totalWait: $totalWait, count $count, hQueue: $hQueue, lQueue: $lQueue");
    //log.write("\n${currentProcess[2] + 1} $currentProcess, currentWork: $currentWork, time: $totalTime, totalWait: $totalWait, count $count, hQueue: $hQueue, lQueue: $lQueue");
  }

  //return CpuResult(totalWait / processes.length, resList, log);
  return lineData(chartLineData, totalTime, processes.length);
}

Widget SRTF_Chart(List<List<int>> processes) {
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
  return lineData(chartLineData, total_time - 1, proc.length - 1);
}

lineData(List<FlSpot> chartLineData, num totalTime, int processLength) {

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
    //const Color(0xff02d39a),
  ];
  List<LineChartBarData> data = [];
  data.add(LineChartBarData(
    spots: chartLineData,
    colors: gradientColors,
    barWidth: 5,
    isStrokeCapRound: true,
    belowBarData: BarAreaData(
        show: true,
        colors: gradientColors.map((color) => color.withOpacity(0.3)).toList()),
  ));
  return Chart(data, totalTime, processLength);
}



class Chart extends StatefulWidget {
  late final List<LineChartBarData> data;
  num totalTime;
  int processLength;
  late List<String> leftTitles = [];
  late List<String> bottomTitles = [];

  Chart(this.data, this.totalTime, this.processLength);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chart'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(color: Color(0xff020227)),
        child: LineChart(LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: const Color(0xff37434d),
                strokeWidth: 1,
              );
            },
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: const Color(0xff37434d),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTextStyles: (value) => const TextStyle(
                  color: Color(0xff68737d),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              getTitles: (value){
                for(int i=0; i<=widget.totalTime; i++){
                  widget.bottomTitles.add(i.toString());
                }
                return widget.bottomTitles[value.toInt()];
              },
              margin: 8,
            ),
            leftTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value) => const TextStyle(
                color: Color(0xff67727d),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              getTitles: (value) {
                for(int i=0; i<=widget.processLength; i++){
                  widget.leftTitles.add('P'+i.toString());
                }
                return widget.leftTitles[value.toInt()];
              },
              reservedSize: 12,
              margin: 12,
            ),
          ),
          borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d), width: 3)),
          minX: 0,
          maxX: (widget.totalTime).toDouble(),
          minY: 0,
          maxY: (widget.processLength+1).toDouble(),
          lineBarsData: widget.data,
        )
        ),
      ),
    );
  }
}
