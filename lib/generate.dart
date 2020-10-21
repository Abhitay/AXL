import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:qrcode/Animation/FadeAnimation.dart';
import 'package:qrcode/noticeDisplay.dart';
import 'package:qrcode/services.dart';
import 'package:qrcode/swipe.dart';
import 'package:qrcode/userSetting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Inputscreen.dart';
import 'data.dart';
import 'global.dart' as globals;

class GeneratePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GeneratePageState();
}

class GeneratePageState extends State<GeneratePage> {
  Future getofflinedata() async {
    print("yes");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      globals.email = preferences.getString("email");
      globals.tempSoc = preferences.getString("soc");
      globals.flatno = preferences.getString("flat");

      Service obj = Service();
      obj.getData();
    });
  }

  @override
  void initState() {
    print("hi");
    getofflinedata();
    super.initState();
  }

  String qrData = globals.flatno + globals.key;

  var formattedDate;
  void handleClick(String value) {
    if (value == "Logout") {
      logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.assignment,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => noticeDisplay(),
                  ));
            },
          ),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        title: Text("  Hi, " + globals.name),
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
          Color.fromRGBO(143, 148, 251, 1),
          Color.fromRGBO(143, 148, 251, .6),
        ]))),
      ),
      resizeToAvoidBottomPadding: false,
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.black,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: Icon(Icons.calendar_today),
            label: "Entry/Exit Log",
            labelStyle: TextStyle(color: Colors.white),
            backgroundColor: Colors.black,
            labelBackgroundColor: Colors.black,
            onTap: () {
              getofflinedata();
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(3030))
                  .then((date) {
                setState(() {
                  formattedDate = "${date.day}-${date.month}-${date.year}";
                  globals.date = formattedDate;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => data()),
                  );
                });
              });
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.settings),
            label: "Settings",
            labelStyle: TextStyle(color: Colors.white),
            labelBackgroundColor: Colors.black,
            backgroundColor: Color.fromRGBO(143, 148, 251, 2),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => usersetting()),
              );
            },
          )
        ],
      ),
      // floatingActionButton: new FloatingActionButton(
      //   child: Container(
      //     width: 60,
      //     height: 60,
      //     child: Icon(Icons.calendar_today),
      //     decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         gradient: LinearGradient(colors: [
      //           Color.fromRGBO(143, 148, 251, 1),
      //           Color.fromRGBO(143, 148, 251, .6),
      //         ])),
      //   ),
      //   onPressed: () {
      //     getofflinedata();
      //     showDatePicker(
      //             context: context,
      //             initialDate: DateTime.now(),
      //             firstDate: DateTime(2020),
      //             lastDate: DateTime(3030))
      //         .then((date) {
      //       setState(() {
      //         formattedDate = "${date.day}-${date.month}-${date.year}";
      //         globals.date = formattedDate;
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => data()),
      //         );
      //       });
      //     });
      //   },
      // ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: QrImage(
                data: qrData,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final qrdataFeed = TextEditingController();

  Future logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("email");
    preferences.remove("soc");
    preferences.remove("flat");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }
}
