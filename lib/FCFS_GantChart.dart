
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


Widget FCFS(List<List<num>> processes) {
  StringBuffer log = new StringBuffer();
  num totalTime = 0;
  num count = 1;
  num totalWait = 0;

  var delayProcess = [0, double.infinity, -1];

  List<num> currentProcess = delayProcess;

  List<CpuProcessBar> resList = [];
  List<Color> colors = List.generate(processes.length, (index) => Color((Random(index).nextDouble() * 0xFFFFFF).toInt()).withOpacity(.2));
  for (var process in processes) {
    if (process[0] > totalTime) {
      int time = process[0] - totalTime as int;
      log.write("\nWaiting for $time");
      resList.add(new CpuProcessBar(totalTime as int, totalTime + time, "", Colors.cyan[100]!));
      //resList.add(new CpuProcessBar(totalTime as int, totalTime + time, "", process[1] != -1 ? colors[process[1] as int] : Colors.cyan[100]!));
      totalTime += time;
    }
    //TODO: Add generated colors here as well
    //var color = colors;
    if (process[0] < totalTime) {
      log.write("\nP$count is waiting for ${totalTime - process[0]}");
      totalWait += totalTime - process[0];
      //color = colors;
    }
    log.write("\nRunning P$count");
    resList.add(CpuProcessBar(totalTime as int, totalTime + (process[1] as int), "P$count", colors[1]));
    //resList.add(CpuProcessBar(totalTime as int, totalTime + (process[1] as int), "P$count", currentProcess[1] != -1 ? colors[currentProcess[1] as int] : Colors.cyan[100]!));
    totalTime += process[1] as int;
    count += 1;
  }
  log.write("\n$processes $totalWait");
  log.write("\nFinished FCFS");
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