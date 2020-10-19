import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qrcode/scan.dart';
import 'package:qrcode/scan_service.dart';
import 'global.dart' as globals;

class m_sendNotice extends StatefulWidget {
  @override
  _m_sendNoticeState createState() => _m_sendNoticeState();
}

class _m_sendNoticeState extends State<m_sendNotice> {
  var noticeError = "";
  void changedata() {
    setState(() {
      noticeError = globals.noticeError;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
          Color.fromRGBO(143, 148, 251, 1),
          Color.fromRGBO(143, 148, 251, .6),
        ]))),
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Type message",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black)),
                  //border: InputBorder.none
                ),
                onChanged: (value) {
                  print("The value entered is: $value");
                  globals.mNotice = "$value";
                  //obj.getData();
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: Colors.black,
                splashColor: Colors.blue,
                child: Text(
                  "Send",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  var date = new DateTime.now().toString();
                  var dateParse = DateTime.parse(date);
                  var formattedDate =
                      "${dateParse.day}-${dateParse.month}-${dateParse.year}";

                  // print(formattedDate);
                  var now = new DateTime.now();

                  String hr = now.hour.toString();
                  String min = now.minute.toString();
                  String t = hr + ":" + min;

                  var fSoc = globals.m_tempsoc + "_notice";

                  var collName = formattedDate + " " + t;

                  if (globals.mNotice == "") {
                    globals.noticeError = "Message empty";
                    changedata();
                  } else {
                    Firestore.instance
                        .collection(fSoc)
                        .document(collName)
                        .setData({
                      'date': collName,
                      'notice': globals.mNotice,
                    }).then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => ScanPage()),
                      );
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              
              child:Center(
              child: Text(
                "$noticeError",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 0, 0, 100)),
              ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
