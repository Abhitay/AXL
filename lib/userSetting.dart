import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/services.dart';
import 'global.dart' as globals;

class usersetting extends StatefulWidget {
  @override
  _usersettingState createState() => _usersettingState();
}

class _usersettingState extends State<usersetting> {
  @override
  bool state = false;
  var oldPass = "none";
  var newPass = "none";
  Service obj = Service();

  Timer _timer;

  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    AlertDialog alert = AlertDialog(
      title: Text("Change password"),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Old password",
              ),
              onChanged: (value) {
                oldPass = "$value";
                obj.getData();
              },
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "New password",
              ),
              onChanged: (value) {
                newPass = "$value";
                obj.getData();
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Ok"),
          onPressed: () {
            if (oldPass == "none" || newPass == "none") {
              (_scaffoldKey.currentState as ScaffoldState)
                  .showSnackBar(SnackBar(
                content: Text("Enter new/old password"),
                duration: Duration(seconds: 1),
              ));

              _timer = new Timer(const Duration(milliseconds: 1200), () {
                setState(() {
                  _scaffoldKey.currentState.hideCurrentSnackBar();
                });
              });

              Navigator.of(context, rootNavigator: true).pop('dialog');
            } else if (oldPass != globals.password && oldPass != "none") {
              (_scaffoldKey.currentState as ScaffoldState)
                  .showSnackBar(SnackBar(
                content: Text("Wrong password"),
                duration: Duration(seconds: 1),
              ));

              _timer = new Timer(const Duration(milliseconds: 1200), () {
                setState(() {
                  _scaffoldKey.currentState..hideCurrentSnackBar();
                });
              });

              Navigator.of(context, rootNavigator: true).pop('dialog');
            } else if (oldPass == globals.password && newPass != "none") {
              (_scaffoldKey.currentState as ScaffoldState)
                  .showSnackBar(SnackBar(content: Text("Password changed")));
              Firestore.instance
                  .collection(globals.tempSoc)
                  .document(globals.flatno)
                  .updateData({"password": newPass}).then((value) {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              });
            }
          },
        ),
      ],
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
          Color.fromRGBO(143, 148, 251, 1),
          Color.fromRGBO(143, 148, 251, .6),
        ]))),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              elevation: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Image.asset("assets/user.png"),
                    title: Text(globals.name),
                    subtitle: Text(globals.number),
                  ),
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        Text("Fingerprint"),
                        Switch(
                            value: state,
                            onChanged: (bool s) {
                              setState(() {
                                state = s;
                              });
                            })
                      ],
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
                //highlightColor: Colors.black,
                splashColor: Colors.blue,
                child: Card(
                  elevation: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.lock),
                        title: Text("Change password"),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
