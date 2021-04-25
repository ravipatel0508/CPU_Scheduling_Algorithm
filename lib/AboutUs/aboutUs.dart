import 'package:flutter/material.dart';
import 'package:scheduling_algorithm/colorAndTheme/colors.dart';
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
                    style: TextStyle(color: textColor, fontSize: 35),
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
                    "-> This project is made with the motive to help the user get a proper understanding of the CPU Scheduling Algorithms along with modern visualizations for a better grasp and ultimate experience.\n\n"
                    "-> We are currently in our Sophomore year pursuing our Bachelor's with majors in Computer Science  in PDEU (Pandit Deendayal Energy University).\n\n"
                    "-> Designed and Implemented by:",
                    style: TextStyle(color: textColor, fontSize: 20),
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
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 4,
                                color: darkButtonColor)),
                        child: Text(
                          'Manav Bhavsar\n19BCP077',
                          style: TextStyle(color: textColor, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 50,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 4,
                              color: darkButtonColor)),
                      child: Text(
                        'Ravi Patel\n19BCP172D',
                        style: TextStyle(color: textColor, fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 50,),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 4,
                              color: darkButtonColor)),
                      child: Text(
                        'Mayank Gupta\n19BCP079',
                        style: TextStyle(color: textColor, fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 50,),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 4,
                              color: darkButtonColor)),
                      child: Text(
                        'Dhrumil Shah\n19BCP164D',
                        style: TextStyle(color: textColor, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 50,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 4,
                              color: darkButtonColor)),
                      child: Text(
                        'Shreya Srivastava\n19BCP123',
                        style: TextStyle(color: textColor, fontSize: 18),
                      ),
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
                    style: TextStyle(color: textColor, fontSize: 15),
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
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }

  void _launchURL() async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
