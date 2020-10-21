import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/data.dart';
import 'global.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';

class input extends StatefulWidget {
  @override
  _inputState createState() => _inputState();
}

class _inputState extends State<input> {
  var selectedType;

  var finaldate;

  var soc = globals.tempSoc + "_details";

  var flat = globals.flatno;

  var formattedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
          Color.fromRGBO(143, 148, 251, 1),
          Color.fromRGBO(143, 148, 251, .6),
        ]))),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 50,
              child:RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: Colors.black,
                child: Text(
                  'Pick a date',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
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
              ),
            ],
          )),
    );
  }
}
