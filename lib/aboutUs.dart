import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  String url = 'https://github.com/ravipatel0508/CPU_Scheduling_Algorithm.git';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8,top: 10,right: 8),
                  child: Text("About Us",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 35),
                  ),
                ),
              ),
            ]),
            Divider(height: 10,),
            Row(children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8,top: 10,right: 8),
                  child: Text(
                    "-> This Web Application is made to fulfil the purpose of our OS project.\n"
                    "-> We are students of PDEU (Pandit Deendayal Energy University) of CSE (Computer Science and Engineering) Department.\n"
                    "-> We currently are in 4th Semester.\n"
                    "-> Designed and Implemented by:",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: Text(
                        'Manav Bhavsar\n19BCP077',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 50,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Ravi Patel\n19BCP172D\n\n',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                    ),
                    Text(
                      'Mayank Gupta\n19BCP079',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                    ),
                    Text(
                      '\n\nDhrumil Shah\n19BCP164D',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(width: 50,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shreya Srivatsava\n19BCP123',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 23),
                  child: Text(
                    'Check out our project on github:  ',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                  ),
                ),
                InkWell(
                    child: Text(
                      'https://github.com/ravipatel0508/CPU_Scheduling_Algorithm.git',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                    onTap: () async {
                      var url =
                          "https://github.com/ravipatel0508/CPU_Scheduling_Algorithm.git";
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _launchURL() async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
