import 'dart:math';
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrcode/m_sendNotice.dart';
import 'package:qrcode/m_service.dart';
import 'package:qrcode/scan_service.dart';
import 'package:qrcode/swipe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart' as globals;

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  Future getofflinedata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      globals.m_email = preferences.getString("m_email");
      globals.m_tempsoc = preferences.getString("m_soc");

      m_Service obj = m_Service();
      obj.getData();
    });
  }

    void handleClick(String value) {
    if (value == "Logout") {
      logout();
    }
  }

  @override
  void initState() {
    print("hi");
    super.initState();
    getofflinedata();
  }

  scan_service obj = scan_service();
  String scan_error = "";
  var tempKey = "";
  var finalcodeSanner = "";
  var temp_codeSanner = "";
  String btnstate = "";
  var mybtnstate = "Upload";
  int confirm = 1;

  File myimage;

  Future getimage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      myimage = image;
    });
  }

  void scan_changedata() {
    setState(() {
      scan_error = globals.scan_error;
      btnstate = mybtnstate;
    });
  }

  String qrCodeResult = "Not Yet Scanned";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.message,
              color: Colors.white,
            ),
            onPressed: () {
              getofflinedata();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => m_sendNotice(),
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
        title: Text("  Hi, " + globals.m_tempsoc + " management"),
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
          child: Icon(Icons.camera_alt),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Color.fromRGBO(143, 148, 251, 1),
                Color.fromRGBO(143, 148, 251, .6),
              ])),
        ),
        onPressed: () {
          getimage();
          obj.getData();
        },
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image(
              image: AssetImage("assets/icon.png"),
              height: 200,
            ),
            Text(
              qrCodeResult,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 80.0,
            ),
            FlatButton(
              padding: EdgeInsets.all(15.0),
              onPressed: () async {
                confirm = 0;
                String codeSanner =
                    await BarcodeScanner.scan(); //barcode scnner
                finalcodeSanner =
                    (codeSanner.substring(0, codeSanner.length - 3));
                temp_codeSanner = codeSanner;
                obj.getData();
                setState(() {
                  qrCodeResult = finalcodeSanner;
                });
              },
              child: Text(
                "Scan",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue, width: 3.0),
                  borderRadius: BorderRadius.circular(20.0)),
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
                  "$mybtnstate",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  if (confirm == 0) {
                    mybtnstate = "Uploaded";

                    obj.getData();
                    var date = new DateTime.now().toString();
                    var dateParse = DateTime.parse(date);
                    var formattedDate =
                        "${dateParse.day}-${dateParse.month}-${dateParse.year}";

                    var now = new DateTime.now();

                    tempKey =
                        temp_codeSanner.substring(temp_codeSanner.length - 3);
                    globals.scan_temp_flat = finalcodeSanner;

                    obj.getData();
                    obj.getData();
                    print("Key: " + globals.check_key);
                    print("Keytemo: " + tempKey);
                    String hr = now.hour.toString();

                    String min = now.minute.toString();
                    String t = hr + "" + min;

                    var uploadStatus;
                    var changestatus;

                    if (globals.status == "1") {
                      uploadStatus = "Enter";
                      changestatus = "0";
                    } else {
                      uploadStatus = "Exit";
                      changestatus = "1";
                    }

                    var i = 1;

                    if (confirm == 1) {
                      globals.scan_error = "Scan QR code";
                      scan_changedata();
                    } else if (myimage == null) {
                      globals.scan_error = "Take image";
                      scan_changedata();
                    } else {
                      obj.getData();
                      if (globals.check_key == tempKey) {
                        globals.scan_error = "Successful";
                        scan_changedata();

                        var fSoc = globals.m_tempsoc + "_details";
                        Random rnd;
                        int min = 100;
                        int max = 999;
                        rnd = new Random();
                        var r = min + rnd.nextInt(max - min);
                        print("$r");

                        var imagename = fSoc +
                            "-" +
                            qrCodeResult +
                            "-" +
                            formattedDate +
                            "-" +
                            t +
                            ".jpg";

                        final StorageReference firebaseStorageRef =
                            FirebaseStorage.instance.ref().child(imagename);

                        final StorageUploadTask task =
                            firebaseStorageRef.putFile(myimage);

                        var dowurl =
                            await (await task.onComplete).ref.getDownloadURL();
                        var url = dowurl.toString();

                        Firestore.instance
                            .collection(fSoc)
                            .document(qrCodeResult)
                            .collection(formattedDate)
                            .document(t)
                            .setData({
                          'hour': now.hour,
                          'minute': now.minute,
                          'status': uploadStatus,
                          'image': url,
                        }).then((value) {
                          Firestore.instance
                              .collection(globals.m_tempsoc)
                              .document(qrCodeResult)
                              .updateData(
                                  {'key': "$r", 'status': changestatus});
                        });
                      } else if (i > 0) {
                        i = i - 1;
                      } else {
                        globals.scan_error = "Alert! key not matching";
                        scan_changedata();
                      }
                    }
                  } else if (confirm == 1) {
                    globals.scan_error = "Scan QR code";
                    scan_changedata();
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "$scan_error",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
    Future logout() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove("m_email");
      preferences.remove("m_soc");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyApp()),
        );
  }
}
