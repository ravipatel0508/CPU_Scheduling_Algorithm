
import 'dart:collection';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheduling_algorithm/appTheme.dart';
import 'package:scheduling_algorithm/colors.dart';


Widget FCFS(List<List<num>> processes) {
  StringBuffer log = new StringBuffer();

  log.writeln("Parsing input\n");
  log.write("Starting First Come First Serve with $processes");

  num totalTime = 0;
  num count = 1;
  num totalWait = 0;

  List<Color> colors = List.generate(processes.length, (index) => light ? Color((Random(index).nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.1) : Color((Random(index).nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2));
  List<CpuProcessBar> resList = [];

  for (var process in processes) {
    if (process[0] > totalTime) {
      int time = process[0] - totalTime as int;
      log.write("\nWaiting for $time");
      resList.add(new CpuProcessBar(totalTime as int, totalTime + time, "", colors[1]));
      totalTime += time;
    }

    var color = colors[2];

    if (process[0] < totalTime) {
      log.write("\nP$count is waiting for ${totalTime - process[0]}");
      totalWait += totalTime - process[0];
      color = colors[3];
    }

    log.write("\nRunning P$count");
    resList.add(CpuProcessBar(totalTime as int, totalTime + (process[1] as int), "P$count", color));
    totalTime += process[1] as int;
    count += 1;
  }

  log.write("\nFinished FCFS");
  return CpuResult(totalWait / processes.length, resList, log);
}

Widget SJF(List<List<num>> processes) {
  StringBuffer log = new StringBuffer();
  log.writeln("Parsing input\n");
  log.write("Starting Shortest Job First with $processes");
  num totalTime = 0;
  num count = 0;
  num totalWait = 0;
  List<CpuProcessBar> resList = [];
  List<Color> colors = List.generate(processes.length, (index) => light ? Color((Random(index).nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.1) : Color((Random(index).nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2));
  var delayProcess = [0, double.infinity, -1];

  List<num> currentProcess = delayProcess;
  num currentWork = 0;
  Queue<List<num>> backlog = new Queue();
  while (true) {
    if (currentProcess[1] == 0) {
      resList.add(CpuProcessBar(totalTime - currentWork as int, totalTime as int, currentProcess[2] != -1 ? "P${currentProcess[2] + 1}" : "", currentProcess[2] != -1 ? colors[currentProcess[2] as int] : Colors.grey));
      log.write("\nFinished P${currentProcess[2] + 1}, saving work ($currentWork) in bar");
      currentWork = 0;
      if (backlog.isNotEmpty) {
        currentProcess = backlog.removeLast();
        log.write("\n   Starting P${currentProcess[2] + 1} again");
      } else {
        log.write("\n   Queue, is empty, starting delay task");
        currentProcess = delayProcess;
      }
    }

    if (count <= processes.length - 1) {
      while (processes[count as int][0] <= totalTime) {
        log.write("\nStarting process P${count + 1} ${processes[count]} at time $totalTime");
        processes[count].add(count);
        if (processes[count][1] < currentProcess[1]) {
          if (currentWork != 0) {
            resList
                .add(CpuProcessBar(totalTime - currentWork as int, totalTime as int, currentProcess[2] != -1 ? "P${currentProcess[2] + 1}" : "", currentProcess[2] != -1 ? colors[currentProcess[2] as int] : Colors.grey));
          }
          log.write("\n   New process is shorter than existing, saving work ($currentWork) in bar and starting P${count + 1}");
          currentWork = 0;

          if (currentProcess[2] != -1) backlog.add(currentProcess);
          currentProcess = processes[count];
        } else {
          log.write("\n   New process is longer than existing, adding to queue");
          backlog.add(processes[count]);
        }
        count++;
        if (count > processes.length - 1) break;
      }
    }

    if (currentProcess[2] == -1 && count >= processes.length) {
      log.write("\nFinished SJF");
      break;
    }

    currentProcess[1]--;
    currentWork++;
    totalTime++;
    backlog.forEach((element) => totalWait++);
    log.write("\n#######P${currentProcess[2] + 1} $currentProcess, currentWork: $currentWork, time: $totalTime, totalWait: $totalWait, count $count, backlog: $backlog");
  }

  return CpuResult(totalWait / processes.length, resList, log);
}

Widget RR(List<List<num>> processes, int n) {
  StringBuffer log = new StringBuffer();
  log.writeln("Parsing input\n");
  log.write("Starting Round Robin ($n) with $processes");
  num totalTime = 0;
  num count = 0;
  num totalWait = 0;
  List<CpuProcessBar> resList = [];
  List<Color> colors = List.generate(processes.length, (index) => light ? Color((Random(index).nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.1) : Color((Random(index).nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2));
  var delayProcess = [0, double.infinity, -1];

  List<num> currentProcess = delayProcess;
  num currentWork = 0;
  Queue<List<num>> backlog = new Queue();
  Queue<List<num>> queue = new Queue();
  while (true) {
    if (count <= processes.length - 1) {
      while (processes[count as int][0] <= totalTime) {
        log.write("\nQueueing process P${count + 1} ${processes[count]} at time $totalTime");
        processes[count].add(count);
        queue.add(processes[count]);
        count++;
        if (count > processes.length - 1) break;
      }
    }

    if (currentProcess[1] == 0 || currentWork == n || (currentProcess[2] == -1 && (backlog.isNotEmpty || queue.isNotEmpty))) {
      if (currentWork != 0)
        resList.add(CpuProcessBar(totalTime - currentWork as int, totalTime as int, currentProcess[2] != -1 ? "P${currentProcess[2] + 1}" : "", currentProcess[2] != -1 ? colors[currentProcess[2] as int] : Colors.grey));
      log.write("\nStopping P${currentProcess[2] + 1}, saving work ($currentWork) in bar");
      if (currentProcess[1] != 0 && currentProcess[2] != -1) {
        log.write("\n   Backlogged P${currentProcess[2] + 1}");
        backlog.add(currentProcess);
      } else {
        log.write("\n   Finished P${currentProcess[2] + 1}");
      }

      currentWork = 0;
      if (queue.isNotEmpty) {
        log.write("\n   Starting P${queue.last[2] + 1} from queue $queue");
        currentProcess = queue.removeFirst();
      } else if (backlog.isNotEmpty) {
        log.write("\n   Starting P${backlog.last[2] + 1} from backlog $backlog");
        currentProcess = backlog.removeFirst();
      } else {
        if (count >= processes.length) break;
        log.write("\n   Queue, is empty, starting delay task");
        currentProcess = delayProcess;
      }
    }

    currentProcess[1]--;
    currentWork++;
    totalTime++;
    backlog.forEach((element) => totalWait++);
    queue.forEach((element) => totalWait++);
    log.write("\n#######P${currentProcess[2] + 1} $currentProcess, currentWork: $currentWork, time: $totalTime, totalWait: $totalWait, count $count, backlog: $backlog");
  }
  log.write("\nFinished RR$n");
  return CpuResult(totalWait / processes.length, resList, log);
}

class CpuResult extends StatefulWidget {
  final double avgWait;
  late final List<CpuProcessBar> list;
  final StringBuffer gg;

  CpuResult(this.avgWait,this.list, this.gg);

  @override
  _CpuResultState createState() => _CpuResultState();
}

class _CpuResultState extends State<CpuResult> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState(){
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 1));

    controller.forward();
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'dash',
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Gantt Chart'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: IntrinsicHeight(
            child: Container(
              margin: EdgeInsets.fromLTRB(30, 50, 30, 50),
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Average wait: ${widget.avgWait.toStringAsFixed(2)}",
                    style: GoogleFonts.sourceCodePro(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizeTransition(
                    sizeFactor: controller,
                    //axis: Axis.vertical,
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        children: widget.list,
                      ),
                    ),
                  ),
                  Container(margin: EdgeInsets.fromLTRB(0.0, 50, 0.0, 0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: light? lightLogColor : darkLogColor,
                        boxShadow: [light ? BoxShadow(color: Colors.grey[600]!, blurRadius: 15) : BoxShadow(color: Colors.black38, blurRadius: 15)]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.gg.toString()),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: light ? lightGantChartColor : darkGantChartColor , boxShadow: [light ? BoxShadow(color: Colors.grey[900]!, blurRadius: 15) : BoxShadow(color: Colors.black, blurRadius: 15)]),
            ),
          ),
        ),
      ),
    );
  }
}

class CpuProcessBar extends StatelessWidget {
  final int start;
  final int end;
  final String text;
  final Color color;

  CpuProcessBar(this.start, this.end, this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: end - start,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border(
            right: BorderSide(),
            left: BorderSide(color: Colors.black.withAlpha(start == 0 ? 255 : 0)),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          overflow: Overflow.visible,
          children: [
            Center(
              child: Text(
                text,
                style: GoogleFonts.sourceCodePro(
                  color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Text(
                end.toString(),
                style: GoogleFonts.sourceCodePro(),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
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
}