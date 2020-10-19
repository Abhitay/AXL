import 'package:qrcode/main.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/scan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart' as globals;
import 'package:qrcode/m_service.dart';
import 'Animation/FadeAnimation.dart';
import 'package:intl/intl.dart';

class DropDown extends StatefulWidget {
  DropDown() : super();

  final String title = "Select society";

  @override
  DropDownState createState() => DropDownState();
}

// class Company {
//   int id;
//   String name;

//   Company(this.id, this.name);

//   static List<Company> getCompanies() {
//     return <Company>[
//       Company(1, 'Society 1'),
//       Company(2, 'Society 2'),
//       Company(3, 'Society 3'),
//       Company(4, 'Society 4'),
//       Company(5, 'Society 5'),
//     ];
//   }
// }

class DropDownState extends State<DropDown> {
  //
  // List<Company> _companies = Company.getCompanies();
  // List<DropdownMenuItem<Company>> _dropdownMenuItems;
  // Company _selectedCompany;

  // @override
  // void initState() {
  //   _dropdownMenuItems = buildDropdownMenuItems(_companies);
  //   _selectedCompany = _dropdownMenuItems[0].value;
  //   super.initState();
  // }

  // List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
  //   List<DropdownMenuItem<Company>> items = List();
  //   for (Company company in companies) {
  //     items.add(
  //       DropdownMenuItem(
  //         value: company,
  //         child: Text(company.name),
  //       ),
  //     );
  //   }
  //   return items;
  // }

  // onChangeDropdownItem(Company selectedCompany) {
  //   setState(() {
  //     _selectedCompany = selectedCompany;
  //   });
  // }

  m_Service obj = m_Service();

  String m_loginError = "";

  var m_accountType;

    void m_changedata(){
    setState(() {
      m_loginError = globals.m_error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                        "Management login",
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
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        FadeAnimation(
                            .4,
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
                                        //print("The value entered is: $value");
                                        globals.m_tempEmail = "$value";
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
                                        //print("The value entered is: $value");
                                        globals.m_tempPass = "$value";
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
                                      decoration: InputDecoration(
                                          hintText: "Society",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                      onChanged: (value) {
                                        //print("The value entered is: $value");
                                        globals.m_tempsoc = "$value";
                                        obj.getData();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text(
                            "$m_loginError",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(255, 0, 0, 100)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // FadeAnimation(
                        //   .5,
                          
                        // ),

                        //Text('Selected: ${_selectedCompany.name}'),

                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            .7,
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
                                  //print();
                                  obj.getData();
                                  //--------------------------
                                  
                                  //------------------------------
                                  if (globals.m_tempEmail == "none" ||
                                      globals.m_tempPass == "none") {
                                    print("Enter text field");
                                    globals.m_error = "Enter text field";
                                    m_changedata();
                                  } else if(globals.m_tempsoc == "none"){
                                    print("Enter correct society");
                                    globals.m_error = "Enter correct society";
                                    m_changedata();
                                  } 
                                  else if (globals.m_tempEmail !=
                                      globals.m_email) {
                                    print("Wrong email");
                                    globals.m_error = "Wrong email";
                                    m_changedata();
                                  } else if (globals.m_tempPass ==
                                          globals.m_password &&
                                      globals.m_tempEmail == globals.m_email) {

                                    m_accountType = "management";
                                    checkm_Login();
                                    
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScanPage()),
                                    );
                                  } else {
                                    print("Wrong password");
                                    globals.m_error = "Wrong password";
                                    m_changedata();
                                  }
                                },
                              ),
                            )),

                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FadeAnimation(
                                  .7,
                                  Container(
                                    height: 50,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      color: Colors.black,
                                      child: Text(
                                        'Resident',
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
                                  )),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: FadeAnimation(
                                  .8,
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
                                        "Management",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                            ),
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
  Future checkm_Login() async {
      print("management running");
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("m_account", m_accountType);
      preferences.setString("m_email", globals.m_email);
      preferences.setString("m_soc", globals.m_tempsoc);
  }
}
