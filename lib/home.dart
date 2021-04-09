import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: TextDirection.ltr,
            verticalDirection: VerticalDirection.down,
            children: [
              SvgPicture.asset(
                'assets/homepageassets/undraw_Processing_re_tbdu.svg',
                height: 200,
                width: 200,
              ),
              Flexible(
                flex: 3,
                child: Column(
                  children:[ Text(
                    'What is CPU Scheduling?',
                    style: TextStyle(
                      color: Colors.blueGrey,
                        fontSize: 24
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'CPU scheduling is a process of determining which process will own CPU for execution while another process is on hold. The main task of CPU Scheduling is to make sure that whenever the CPU remains idle, the OS at least selects one of the processes available in the ready queue for execution. The selection procedure will be carried out by the CPU Scheduler. It selects one of the processes in the memory that are ready for execution.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                ]
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Divider(height: 10,),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: TextDirection.ltr,
            verticalDirection: VerticalDirection.down,
            children: [
              Flexible(
                flex: 3,
                child: Column(children: [
                  Text(
                    'How does the scheduler decide which process to select?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 24
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50,top: 8,right: 50),
                    child: Text(
                      'The scheduler can decide based on different algorithms that come under CPU Scheduling that allows selection in different ways as required. These algorithms decide the criteria and rules to select the process.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ]),
              ),
              SvgPicture.asset(
                'assets/homepageassets/undraw_selection_re_ycpo.svg',
                height: 300,
                width: 300,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Divider(height: 10,),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            textDirection: TextDirection.ltr,
            verticalDirection: VerticalDirection.down,
            children: [
              SvgPicture.asset(
                'assets/homepageassets/undraw_Cloud_docs_re_xjht.svg',
                height: 250,
                width: 250,
              ),
              Flexible(
                flex: 3,
                child: Column(
                  children:[ Text(
                    'What are the Algorithms?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    '''In this project you will mainly get to see the following algorithms in action:
                        1. First Come First Serve (FCFS)
                        2. Shortest Job First (SJF)
                        3. Shortest Remaining Time First (SRTF)
                        4. Round Robin Scheduling
                        5. TL – FCFS (Unique)''',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                ]
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}
