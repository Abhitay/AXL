import 'package:flutter/material.dart';
import 'package:qrcode/generate.dart';

import 'main.dart';

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}

class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        print("Not logged in");
        retVal = HomePage();
        break;

      case AuthStatus.loggedIn:
        print("Logged in");
        retVal = GeneratePage();
        break;
      default:
    }
    return retVal;
  }
}
