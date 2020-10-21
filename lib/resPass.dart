import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_auth/local_auth.dart';
import 'package:qrcode/generate.dart';
import 'package:qrcode/scan.dart';
import 'package:qrcode/scan_service.dart';
import 'package:qrcode/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart' as globals;

class resPass extends StatefulWidget {
  @override
  _resPassState createState() => _resPassState();
}

class _resPassState extends State<resPass> {
  Future getofflinedata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      globals.tempEmail = preferences.getString("email");
      globals.tempSoc = preferences.getString("soc");
      globals.flatno = preferences.getString("flat");

      Service obj = Service();
      obj.getData();
    });
  }

  @override
  void initState() {
    print("hi");
    super.initState();
    getofflinedata();
    _checkBio();
    _getavailableBio();
    _auth();
  }

  Service obj = Service();

  bool _canCheckBio;
  List<BiometricType> _availableBio;
  String _authorized = "Not authorized";
  LocalAuthentication auth = LocalAuthentication();

  Future<void> _checkBio() async {
    bool canCheckbio;
    try {
      canCheckbio = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBio = canCheckbio;
    });
  }

  Future<void> _getavailableBio() async {
    List<BiometricType> avalableBio;
    try {
      avalableBio = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _availableBio = avalableBio;
    });
  }

  Future<void> _auth() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
        localizedReason: "Scan your fingerprint to authenticate",
        useErrorDialogs: true,
        stickyAuth: false,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _authorized = authenticated ? "Authorized" : "Not authorized";
      if (_authorized == "Authorized") {
        nextpage();
      }
    });
  }

  void nextpage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GeneratePage()),
    );
  }

  var passwordError = "";
  void changedata() {
    setState(() {
      passwordError = globals.passError;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter password",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black)),
                ),
                onChanged: (value) {
                  print("The value entered is: $value");
                  globals.passEnter = "$value";
                  getofflinedata();
                  obj.getData();
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
                  "Next",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  getofflinedata();
                  obj.getData();
                  if (globals.passEnter == "") {
                    globals.passError = "Enter password";
                    changedata();
                  } else if (globals.passEnter != globals.password) {
                    globals.passError = "Wrong password";
                    changedata();
                  } else if (globals.passEnter == globals.password) {
                    _authorized = "Authorized";
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GeneratePage()),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RawMaterialButton(
              onPressed: () {
                _auth();
              },
              elevation: 4.0,
              fillColor: Colors.white,
              child: Icon(
                Icons.fingerprint,
                size: 25.0,
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: Center(
              child: Text(
                "$passwordError",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 0, 0, 100)),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
