import 'dart:math' as math show pi;

import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:scheduling_algorithm/aboutUs.dart';
import 'package:scheduling_algorithm/help.dart';
import 'package:scheduling_algorithm/Implementation.dart';
import 'package:scheduling_algorithm/home.dart';
import 'package:scheduling_algorithm/information.dart';
import 'package:scheduling_algorithm/projectSelection.dart';
import 'package:url_launcher/url_launcher.dart';

import 'colorAndTheme/appTheme.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SidebarPage(),
    );
  }
}

class SidebarPage extends StatefulWidget {
  @override
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  late List<CollapsibleItem> _items;
  Widget _widget = HomePage();
  NetworkImage _avatarImg =
  NetworkImage('https://www.w3schools.com/howto/img_avatar.png');


  @override
  void initState() {
    super.initState();
    _items = _generateItems;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Home',
        icon: Icons.home,
        onPressed: () => setState((){
          _widget = HomePage();
        }),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Information',
        icon: Icons.announcement_rounded,
        onPressed: () => setState(() {
          _widget = Information();
        }),
      ),
      CollapsibleItem(
        text: 'Implementation',
        icon: Icons.addchart_rounded,
        onPressed: () => setState(() {
          _widget = Implementation();
        }),
      ),
      CollapsibleItem(
        text: 'About us',
        icon: Icons.info_outline_rounded,
        onPressed: () => setState(() {
          _widget = AboutUs();
        }),
      ),
      /*CollapsibleItem(
        text: 'Help',
        icon: Icons.help_outline_rounded,
        onPressed: () => setState(() {
          _widget = Help();
        }),
      ),*/
      CollapsibleItem(
        text: 'Senior Project',
        icon: Icons.grade_outlined,
        onPressed: () async {
          var url =
              "https://disk-visualizer.web.app/";
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
//    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: CollapsibleSidebar(
        items: _items,
        avatarImg: _avatarImg,
        title: 'Team-27',
        body: _body(context),
        backgroundColor: Colors.blueGrey,
        unselectedIconColor: Colors.black38,
        //selectedTextColor: Colors.limeAccent,
        textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        titleStyle: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        toggleTitleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return _widget;
  }
}
