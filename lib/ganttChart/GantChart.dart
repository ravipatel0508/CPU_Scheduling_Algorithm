
import 'dart:collection';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheduling_algorithm/colorAndTheme/appTheme.dart';
import 'package:scheduling_algorithm/colorAndTheme/colors.dart';



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
  //print(currentProcess[1]);
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

    //print(processes[0]);
    //print(totalTime);
    if (count <= processes.length - 1) {
      while (processes[count as int][0] <= totalTime) {
        log.write("\nStarting process P${count + 1} ${processes[count]} at time $totalTime");
        processes[count].add(count);
        print(processes[count]);
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
    //print(backlog);
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

Widget SRTF(List<List<int>> processes) {
  StringBuffer log = new StringBuffer();

  List<CpuProcessBar> resList = [];
  List<List<int>> proc = processes;
//List<List<int>> proc = [[0, 5], [6, 9], [6, 5], [15,10]];
  //List<List<int>> proc = [[0,2],[0,4],[12,4],[15,5],[21,10]];

  List<double> wT = [0, 0, 0, 0, 0];
  List<double> tT = [0, 0, 0, 0, 0];
  int n = proc.length - 1;
  List<int> start = [];
  List<int> end = [];
  List<String> text = [];

  //Calculation of Total Time and Initialization of Time Chart array
  int total_time = 0;

  for (int i = 0; i <= n; i++) {
    total_time += proc[i][1];
    // time_chart.add(total_time);
  }
  //print("Tootal"+total_time.toString());
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
          //print(sel_proc);
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
          //proc[j][3]++;//If process has arrived and it has not already completed execution its TT is incremented by 1
          tT[j]++;
          if(j != sel_proc)//If the process has not been currently assigned the CPU and has arrived its WT is incremented by 1
              {
            //proc[j][2]++;
            wT[j]++;
          }
        }
        else if(j == sel_proc)//This is a special case in which the process has been assigned CPU and has completed its execution
          //proc[j][3]++;
          tT[j]++;
      }
    }

    //Printing the Time Chart
    /*if(i != 0)
    {
      if(sel_proc != time_chart[i - 1]) //If the CPU has been assigned to a different Process we need to print the current value of time and the name of the new Process
      {
        if((sel_proc) == -1) {
          log.write("--" + i.toString() + " ");
          end.add(i);
          start.add(i);
          text.add("__");
        } else {
          log.write("--" + i.toString() + "--P" + sel_proc.toString());
          end.add(i);
          start.add(i);
          text.add("P" + (sel_proc).toString());
        }
      }
    }
    else//If the current time is 0 i.e the printing has just started we need to print the name of the First selected Process
    {
      log.write(i.toString() + "--P" + sel_proc.toString());
      end.add(i);
      start.add(i);
      text.add("P" + sel_proc.toString());
    }
    if(i == total_time - 1)//All the process names have been printed now we have to print the time at which execution ends
    {
      log.write("--" + i.toString());
      end.add(i);
      start.add(i);
      text.add("P" + sel_proc.toString());
    }*/
    if(i != 0)
    {
      if(sel_proc != time_chart[i - 1]) //If the CPU has been assigned to a different Process we need to print the current value of time and the name of//the new Process
      {
        print(sel_proc - 1);
        /*if((sel_proc - 1) >= 0) {
          start.add(i);
          end.add(i);
          log.write("--" + i.toString() + "--P" + (sel_proc - 1).toString());
          text.add("P" + (sel_proc - 1).toString());

        }
        else {
          log.write("--" + i.toString() + "  ");
          start.add(i);
          end.add(i);
          print("sdnfisnd");
          text.add(" ");
        }*/
          start.add(i);
          end.add(i);
          log.write("--" + i.toString() + "--P" + (sel_proc - 1).toString());
          text.add("P" + (sel_proc).toString());
      }
    }
    else//If the current time is 0 i.e the printing has just started we need to print the name of the First selected Process
    {
        log.write(i.toString() + "--P" + (sel_proc - 1).toString());
        start.add(i);
        end.add(i);
        text.add("P" + (sel_proc - 1).toString());
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
    resList.add(CpuProcessBar(
        start[i], end[i], text[i], Colors.amberAccent));
  }

  print("Start:" + start.toString());
  print("End:" + end.toString());

  return CpuResult(WT, resList, log);
}

Widget TL_FCFS(List<List<num>> processes) {
  StringBuffer log = new StringBuffer();
  log.writeln("Parsing input\n");
  log.write("Starting Two-Layer First Come First Serve with $processes");
  num totalTime = 0;
  num count = 0;
  num totalWait = 0;
  List<CpuProcessBar> resList = [];
  List<Color> colors = List.generate(processes.length, (index) => Color((Random(index).nextDouble() * 0xFFFFFF).toInt()).withOpacity(.2));
  var delayProcess = [0, double.infinity, -1];

  List<num> currentProcess = delayProcess;
  num currentWork = 0;
  Queue<List<num>> hQueue = new Queue();
  Queue<List<num>> lQueue = new Queue();
  bool processingLow = false;
  while (true) {
    if (currentProcess[1] == 0) {
      resList.add(CpuProcessBar(totalTime - currentWork as int, totalTime as int, currentProcess[2] != -1 ? "P${currentProcess[2] + 1}" : "", currentProcess[2] != -1 ? colors[currentProcess[2] as int] : Colors.cyan[100]!));
      log.write("\nFinished P${currentProcess[2] + 1}, saving work ($currentWork) in bar");
      currentWork = 0;
      if (hQueue.isNotEmpty) {
        processingLow = false;
        currentProcess = hQueue.removeLast();
        log.write("\n   Starting P${currentProcess[2] + 1} from high-priority queue");
      } else if (lQueue.isNotEmpty) {
        processingLow = true;
        currentProcess = lQueue.removeLast();
        log.write("\n   Starting P${currentProcess[2] + 1} from low-priority queue");
      } else {
        processingLow = true;
        log.write("\n   Starting delay task");
        currentProcess = delayProcess;
      }
    }

    if (count <= processes.length - 1) {
      while (processes[count as int][0] <= totalTime) {
        log.write("\nQueueing process P${count + 1} ${processes[count]} at time $totalTime");
        processes[count].add(count);
        if ((processes[count][1] <= 6 && processingLow) || currentProcess[2] == -1) {
          if (currentWork != 0) {
            resList
                .add(CpuProcessBar(totalTime - currentWork as int, totalTime as int, currentProcess[2] != -1 ? "P${currentProcess[2] + 1}" : "", currentProcess[2] != -1 ? colors[currentProcess[2] as int] : Colors.cyan[100]!));
          }
          log.write("\n   New process is higher priority than P${currentProcess[2] + 1}, saving work ($currentWork) in bar and starting P${count + 1}");
          currentWork = 0;

          if (currentProcess[2] != -1) {
            if (processingLow) {
              log.write("\n   Adding P${count + 1} back to low-priority queue");
              lQueue.add(currentProcess);
            } else {
              log.write("\n   Adding P${count + 1} back to high-priority queue");
              hQueue.add(currentProcess);
            }
          }

          currentProcess = processes[count];
        } else if (processes[count][1] <= 6) {
          log.write("\n   Adding P${count + 1} to high-priority queue");
          hQueue.add(processes[count]);
        } else {
          log.write("\n   Adding P${count + 1} to low-priority queue");
          lQueue.add(processes[count]);
        }
        count++;
        if (count > processes.length - 1) break;
      }
    }

    if (currentProcess[2] == -1 && count >= processes.length) {
      log.write("\nFinished TL_FCFS");
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
          backgroundColor: light ? lightPrimaryColor : darkPrimaryColor,
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