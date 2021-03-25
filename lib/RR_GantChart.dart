
import 'dart:collection';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

StringBuffer log = new StringBuffer();

Widget RR(List<List<num>> processes, int n) {
  log.write("Starting Round Robin ($n) with $processes");
  num totalTime = 0;
  num count = 0;
  num totalWait = 0;
  List<CpuProcessBar> resList = [];
  List<Color> colors = List.generate(processes.length, (index) => Color((Random(index).nextDouble() * 0xFFFFFF).toInt()).withOpacity(.2));
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
        resList.add(CpuProcessBar(totalTime - currentWork as int, totalTime as int, currentProcess[2] != -1 ? "P${currentProcess[2] + 1}" : "", currentProcess[2] != -1 ? colors[currentProcess[2] as int] : Colors.cyan[100]!));
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
    //log.write("\n#######P${currentProcess[2] + 1} $currentProcess, currentWork: $currentWork, time: $totalTime, totalWait: $totalWait, count $count, backlog: $backlog");
    //log.write("\n${currentProcess[2] + 1} $currentProcess, currentWork: $currentWork, time: $totalTime, totalWait: $totalWait, count $count, backlog: $backlog");
  }
  log.write("\nFinished RR$n");
  return CpuResult(totalWait / processes.length, resList, log);
}

class CpuResult extends StatelessWidget {
  final double avgWait;
  late final List<CpuProcessBar> list;
  final StringBuffer gg;

  CpuResult(this.avgWait,this.list, this.gg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gantt Chart'),
      ),
      body: IntrinsicHeight(
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 50, 30, 50),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.blue[200], boxShadow: [BoxShadow(color: Colors.grey[900]!, blurRadius: 15)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Average wait: ${avgWait.toStringAsFixed(2)}",
                style: GoogleFonts.sourceCodePro(),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: Row(
                  children: list,
                ),
              ),
              Container(margin: EdgeInsets.fromLTRB(0.0, 50, 0.0, 0.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.blue[100],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(gg.toString()),
                ),
              )
            ],
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
}