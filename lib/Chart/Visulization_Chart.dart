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
