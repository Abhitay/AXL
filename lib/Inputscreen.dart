//import 'dart:html';

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

  // List<String> _date = <String>[
  //   "hi",
  //   "Demo"
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("Hi, " + globals.name),
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
              // Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       // DropdownButton(
              //       //   items: _date
              //       //       .map((value) => DropdownMenuItem(
              //       //             child: Text(
              //       //               value,
              //       //               //style: ,
              //       //             ),
              //       //             value: value,
              //       //           ))
              //       //       .toList(),
              //       //   onChanged: (selectedDate) {
              //       //     setState(() {
              //       //       selectedType = selectedDate;
              //       //     });
              //       //   },
              //       //   value: selectedType,
              //       //   isExpanded: false,
              //       //   hint: Text("Choose date"),
              //       // ),
              //       // SizedBox(
              //       //   height: 40.0,
              //       // ),
              //       // StreamBuilder<QuerySnapshot>(
              //       //   stream: Firestore.instance.collection("soc2_details").snapshots(),
              //       //   builder: (context, snapshot) {
              //       //     if (!snapshot.hasData) {
              //       //       Text("Loading");
              //       //     } else {
              //       //       List<DropdownMenuItem> currentItem = [];
              //       //       for (int i = 0;
              //       //           i < snapshot.data.documents.length;
              //       //           i++) {
              //       //         DocumentSnapshot snap = snapshot.data.documents[i];
              //       //         currentItem.add(DropdownMenuItem(
              //       //           child: Text(
              //       //             snap.documentID,
              //       //             //style: ,
              //       //           ),
              //       //           value: "${snap.documentID}",
              //       //         ));
              //       //       }
              //       //       return Row(
              //       //         mainAxisAlignment: MainAxisAlignment.center,
              //       //         children: <Widget>[
              //       //           DropdownButton(
              //       //             items: currentItem,
              //       //             onChanged: (currentValue) {
              //       //               final snackBar = SnackBar(
              //       //                 content: Text("Selected: $currentValue"),
              //       //               );
              //       //               Scaffold.of(context).showSnackBar(snackBar);
              //       //               setState(() {
              //       //                 finaldate = currentValue;
              //       //               });
              //       //             },
              //       //             value: finaldate,
              //       //             isExpanded: false,
              //       //             hint: new Text("Choose"),
              //       //           ),
              //       //         ],
              //       //       );
              //       //     }
              //       //   },
              //       // ),
              //     ]),
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
              // TextField(
              //   decoration: InputDecoration(
              //     hintText: "Date (D-M-YYYY)",
              //     hintStyle: TextStyle(color: Colors.grey),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.black, width: 1.0),
              //     ),
              //   ),
              //   onChanged: (value) {
              //     //print("The value entered is: $value");
              //     globals.date = "$value";
              //     //obj.getData();
              //   },
              // ),
              // SizedBox(
              //   height: 40.0,
              // ),
              // Container(
              //   height: 50,
              //   child: RaisedButton(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(50),
              //     ),
              //     color: Colors.lightBlue,
              //     child: Text(
              //       'Next',
              //       style: TextStyle(
              //           color: Colors.white, fontWeight: FontWeight.bold),
              //     ),
              //     onPressed: () {
              //       // var date = DateTime.parse("2019-04-16 12:18:06.018950");
              //       // var formattedDate =
              //       //     "${date.day}-${date.month}-${date.year}";
              //       //print(formattedDate);

              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => data()),
              //       );
              //     },
              //   ),
              // ),
              //               SizedBox(
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
              //       'Images',
              //       style: TextStyle(
              //           color: Colors.white, fontWeight: FontWeight.bold),
              //     ),
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => image()),
              //       );
              //     },
              //   ),
              // ),
            ],
          )),
    );
  }
}
