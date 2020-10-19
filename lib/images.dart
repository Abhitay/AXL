import 'package:flutter/material.dart';

class image extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Image.network(
        "https://firebasestorage.googleapis.com/v0/b/axlproject-e461f.appspot.com/o/soc1_details-flat1-15-10-2020-1613.jpg?alt=media&token=55a1e15d-3634-45c6-a2ae-a5abd00c2118")
          ],
        ),
      ),
    );
  }
}
