import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scheduling_algorithm/dashboard.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectSelection extends StatefulWidget {
  @override
  _ProjectSelectionState createState() => _ProjectSelectionState();
}

class _ProjectSelectionState extends State<ProjectSelection> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        SvgPicture.asset('assets/selection.svg'),
        Container(
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xff435956))
                        )
                    ),
                  ),
                    onPressed: () async {
                  var url =
                      "https://disk-visualizer.web.app/";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }, child: Text('Disk Scheduling Algorithm',)),
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Color(0xff435956))
                      )
                      ),
                    ),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        Dashboard())), child: Text('CPU Scheduling Algorithm')),
              )
            ],
          ),
        ),
      ),
    ]
    );
  }
}
