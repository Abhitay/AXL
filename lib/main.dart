import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qrcode/Animation/FadeAnimation.dart';
import 'package:qrcode/generate.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/resPass.dart';
import 'package:qrcode/scan.dart';
import 'package:qrcode/services.dart';
import 'package:qrcode/swipe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart' as globals;
import 'M_list.dart';

final databaseReference = Firestore.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString("email");
  var m_email = preferences.getString("m_email");
  globals.tempSoc = preferences.getString("soc");
  globals.flatno = preferences.getString("flat");
  var accountType = preferences.getString("account");
  var m_accountType = preferences.getString("m_account");
  

  Service obj = Service();
  obj.getData();

  if(accountType == "res"){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: 
    email == null ? MyApp() : resPass(),
  ));
  }
  else if(m_accountType == "management"){
    runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: 
    m_email == null ? MyApp() : ScanPage(),
  ));
  }
  else{
    runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
  }

}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Service obj = Service();

  var accountType;

  String loginError = "";

  void changedata() {
    setState(() {
      loginError = globals.error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(143, 148, 251, 1),
          Color.fromRGBO(143, 148, 251, .6),
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "AXL",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 0,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Resident login",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, .3),
                                        blurRadius: 15,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: "Email",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                      onChanged: (value) {
                                        globals.tempEmail = "$value";
                                        obj.getData();
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                      onChanged: (value) {
                                        globals.tempPass = "$value";
                                        obj.getData();
                                      },
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextField(
                                            decoration: InputDecoration(
                                                hintText: "Society",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none),
                                            onChanged: (value) {
                                              globals.tempSoc = "$value";
                                              obj.getData();
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 40.0,
                                        width: 1.0,
                                        color: Colors.black,
                                        margin:
                                            const EdgeInsets.only(right: 10.0),
                                      ),
                                      VerticalDivider(),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextField(
                                            decoration: InputDecoration(
                                                hintText: "Flat number",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none),
                                            onChanged: (value) {
                                              globals.flatno = "$value";
                                              obj.getData();
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 45,
                        ),
                        Container(
                          child: Text(
                            "$loginError",
                            //globals.error,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(255, 0, 0, 100)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            1.9,
                            Container(
                              height: 50,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                color: Colors.black,
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {

                                  obj.getData();

                                  if (globals.tempEmail == "none" ||
                                      globals.tempPass == "none") {
                                    print("Enter text field");
                                    globals.error = "Enter text field";
                                    changedata();
                                  } else if (globals.tempSoc == "none") {
                                    print("Enter correct society");
                                    globals.error = "Enter correct society";
                                    changedata();
                                  } else if (globals.email == "none" ||
                                      globals.flatno == "none" ||
                                      globals.password == "none") {
                                    print("Flat not found");
                                    globals.error = "Flat not found";
                                    changedata();
                                  } else if (globals.tempPass !=
                                      globals.password) {
                                    print("Wrong password");
                                    globals.error = "Wrong password";
                                    changedata();
                                  } else if (globals.email !=
                                      globals.tempEmail) {
                                    print("Wrong username");
                                    globals.error = "Wrong username";
                                    changedata();
                                  } else if (globals.email ==
                                          globals.tempEmail &&
                                      globals.tempPass == globals.password) {
                                    accountType = "res";
                                    checkLogin();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GeneratePage()),
                                    );
                                  }
                                },
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FadeAnimation(
                                  1.8,
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        gradient: LinearGradient(colors: [
                                          Color.fromRGBO(143, 148, 251, 1),
                                          Color.fromRGBO(143, 148, 251, .6),
                                        ])),
                                    child: Center(
                                      child: Text(
                                        "Resident",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: FadeAnimation(
                                  1.9,
                                  Container(
                                    height: 50,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      color: Colors.black,
                                      child: Text(
                                        'Management',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DropDown()),
                                        );
                                      },
                                    ),
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future checkLogin() async {
    print("running");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("account", accountType);
    preferences.setString("email", globals.email);
    preferences.setString("soc", globals.tempSoc);
    preferences.setString("flat", globals.flatno);
    preferences.setString("biometric", "false");
  }
}
