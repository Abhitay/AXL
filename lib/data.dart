import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/Inputscreen.dart';
import 'package:qrcode/generate.dart';
import 'global.dart' as globals;

class data extends StatelessWidget {
  var soc = globals.tempSoc + "_details";
  var flat = globals.flatno;

  @override
  Widget build(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text(globals.date),
      content: Text("No data found"),
      actions: <Widget>[
        FlatButton(
          child: Text("Ok"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GeneratePage()),
            );
          },
        ),
      ],
    );
    return Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          //title: Text("  Hi, " + globals.name),
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
            Color.fromRGBO(143, 148, 251, 1),
            Color.fromRGBO(143, 148, 251, .6),
          ]))),
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection(soc)
              .document(flat)
              .collection(globals.date)
              .snapshots(),
          builder: (context, snapshot) {
            // if (!snapshot.hasData) return new Text("No data");
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return alert;
            //   },
            // );
            if (snapshot.data.documents.isEmpty) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                ),
              );
              return new Text("");
            } else if (!snapshot.data.documents.isEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(30),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot course = snapshot.data.documents[index];
                  if (!snapshot.data.documents.isEmpty) {
                    return ListTile(
                      leading: Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(113, 148, 241, 100),
                            image: new DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: new NetworkImage(
                                    course['image'].toString()))),
                      ),
                      title: Text(course['hour'].toString() +
                          ":" +
                          course['minute'].toString()),
                      subtitle: Text(course['status']),
                    );
                  }
                },
              );
            }
          },
        ));
  }
}
