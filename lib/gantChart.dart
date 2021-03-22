
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



Widget FCFS(List<List<num>> processes, List<int> arrivalList, List<int> bustList) {
  num totalTime = 0;
  num count = 1;
  num totalWait = 0;
  StringBuffer log = new StringBuffer();
  //List<List<int>> DATATA= [[1, 2], [2,4], [3,6]];

  List<CpuProcessBar> resList = [];

  // for(int i=0; i<arrivalList.length; i++){
  //   if(int.parse(arrivalList[0].toString()) > totalTime){
  //     int time = int.parse(arrivalList[0].toString()) - totalTime as int;
  //     log.write("\nWaiting for $time");
  //     resList.add(new CpuProcessBar(totalTime as int, totalTime + time));
  //     totalTime += time;
  //   }
  //   if(int.parse(arrivalList[1].toString()) < totalTime){
  //     log.write("\nP$count is waiting for ${totalTime - int.parse(arrivalList[0].toString())}");
  //     totalWait += totalTime - int.parse(arrivalList[0].toString());
  //   }
  //   log.write("\nRunning P$count");
  //   resList.add(CpuProcessBar(totalTime as int, totalTime + int.parse(arrivalList[0].toString())));
  //   totalTime += int.parse(arrivalList[1].toString());
  //   count += 1;
  // }
  // log.write("\n$DATATA $totalWait");
  // log.write("\nFinished FCFS");

  // //List<Color> colors = List.generate(processes.length, (index) => Color((Random(index).nextDouble() * 0xFFFFFF).toInt()).withOpacity(.2));
  for (var process in processes) {
    if (process[0] > totalTime) {
      int time = process[0] - totalTime as int;
      log.write("\nWaiting for $time");
      resList.add(new CpuProcessBar(totalTime as int, totalTime + time));
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
    resList.add(CpuProcessBar(totalTime as int, totalTime + (process[0] as int)));
    //resList.add(CpuProcessBar(totalTime as int, totalTime + (process[1] as int), "P$count", currentProcess[1] != -1 ? colors[currentProcess[1] as int] : Colors.cyan[100]!));
    totalTime += process[1] as int;
    count += 1;
  }
  log.write("\n$processes $totalWait");
  log.write("\nFinished FCFS");

  // resList.add(new CpuProcessBar(3));
  // resList.add(CpuProcessBar(10));
  // resList.add(CpuProcessBar(15));

  return CpuResult(resList,log);
}

class CpuResult extends StatelessWidget {
  final double avgWait =3;
  late final List<CpuProcessBar> list;
  final StringBuffer gg;

  CpuResult(this.list, this.gg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gantt Chart'),
      ),
      body: Container(
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
    );
  }
}

class CpuProcessBar extends StatelessWidget {
  final int start;
  final int end;
  //final int flex;

  CpuProcessBar(this.start, this.end);


  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: end - start,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
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
                (end-start).toString(),
                //text,
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