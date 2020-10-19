import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:qrcode/Animation/FadeAnimation.dart';
import 'package:qrcode/noticeDisplay.dart';
import 'package:qrcode/services.dart';
import 'package:qrcode/swipe.dart';
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

  String qrData = globals.flatno +
      globals.key; // already generated qr code when the page opens

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
      floatingActionButton: new FloatingActionButton(
        child: Container(
          width: 60,
          height: 60,
          child: Icon(Icons.calendar_today),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Color.fromRGBO(143, 148, 251, 1),
                Color.fromRGBO(143, 148, 251, .6),
              ])),
        ),
        onPressed: () {
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
                //plce where the QR Image will be shown
                data: qrData,
              ),
            ),
            // SizedBox(
            //   height: 40.0,
            // ),
            // Container(
            //   height: 50,
            //   child: RaisedButton(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(50),
            //     ),
            //     color: Colors.black,
            //     child: Text(
            //       'Log',
            //       style: TextStyle(
            //           color: Colors.white, fontWeight: FontWeight.bold),
            //     ),
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => input()),
            //       );
            //     },
            //   ),
            // ),
            /*Text(
                    "New QR Link Generator",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  TextField(
                    controller: qrdataFeed,
                    decoration: InputDecoration(
                      hintText: "Input your link or data",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: FlatButton(
                      padding: EdgeInsets.all(15.0),
                      onPressed: () async {
      
                        if (qrdataFeed.text.isEmpty) {        //a little validation for the textfield
                          setState(() {
                            qrData = "";
                          });
                        } else {
                          setState(() {
                            qrData = "flat1";
                          });
                        }
      
                      },
                      /* child: Text(
                        "Generate QR",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue, width: 3.0),
                          borderRadius: BorderRadius.circular(20.0)) ,*/
                    ),
                  )*/
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
      MaterialPageRoute(
        builder: (context) => MyApp()),
      );
  }
}
