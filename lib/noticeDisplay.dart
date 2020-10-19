import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/Inputscreen.dart';
import 'package:qrcode/generate.dart';
import 'global.dart' as globals;

class noticeDisplay extends StatelessWidget {
  var soc = globals.tempSoc + "_notice";

  @override
  Widget build(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("No notice yet"),
      content: Text("Try again later"),
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
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
            Color.fromRGBO(143, 148, 251, 1),
            Color.fromRGBO(143, 148, 251, .6),
          ]))),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection(soc).snapshots(),
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
              Card(
                elevation: 10,
              );
              return ListView.builder(
                padding: const EdgeInsets.all(30),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) 
                {
                  DocumentSnapshot course = snapshot.data.documents[index];
                  if (!snapshot.data.documents.isEmpty) {
                    return ListTile(
                      title: Text(course['date'].toString()),
                      subtitle: Text(course['notice']),
                    );
                  }
                },
              );
            }
          },
        ));
  }
}
