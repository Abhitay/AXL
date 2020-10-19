import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:qrcode/main.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pages = [
  Container(
    //     decoration: BoxDecoration(
    //   gradient: LinearGradient(
    //   begin: Alignment.bottomRight,
    //   end: Alignment.topLeft,
    //   colors: [
    //   Color.fromRGBO(143, 148, 251, .1),
    //   Color.fromRGBO(143, 148, 251, 100),
    // ])),
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: Image(image: AssetImage("assets/icon.png"), height: 300,),
          ),
        // Center(
        // child: Row(
        //   children: <Widget>[
        //     Text("Meet team AXL"),
        //     //Center(child: Image(image: AssetImage("assets/icon.png"), height: 200,),)
        //   ],
        // )
        // ),
        Column(
          children: <Widget>[
            Text("Meet AXL",
            style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ]
        ),
      ],
    ),
  ),
  Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [
      Color.fromRGBO(143, 148, 251, 2),
      Color.fromRGBO(143, 148, 251, .2),
    ])),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: Image(image: AssetImage("assets/slideImage2.png"), height: 300,),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Hassle free entry in societies.",
            style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Secure . Fast . AXL",
            style: TextStyle(color: Color.fromRGBO(45, 70, 135, 100), fontSize: 30, fontWeight: FontWeight.bold)),
            )
          ]
        ),
        Row(
          children: <Widget>[
            // Text("Hi"),
            Center(child:  Padding(
              padding: EdgeInsets.all(16.0),
              child: RaisedButton(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
              color: Colors.black,
              child: Text(
                'Next',
                  style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => HomePage()),
                  );
                },
            ),
            ),)
           
          ],
        ),
      ],
    ),
  ),
];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LiquidSwipe(
          pages: pages,
          enableLoop: true,
          fullTransitionValue: 300,
          enableSlideIcon: true,
          waveType: WaveType.liquidReveal,
          positionSlideIcon: 0.5,
        )
      ),
    );
  }
}
