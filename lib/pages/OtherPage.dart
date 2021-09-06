import 'package:fishRajkumar/components/Header.dart';
import 'package:fishRajkumar/pages/DashboardPage.dart';
import 'package:fishRajkumar/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fishRajkumar/components/NavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtherPage extends StatefulWidget {
  @override
  _OtherPageState createState() => _OtherPageState();
}

var userid;

class _OtherPageState extends State<OtherPage> {
  void initState() {
    super.initState();
    _incrementCounter();
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid =
          (prefs.getString('userid') != null ? prefs.getString('userid') : '');
    });
  }

  bool _isLogin = (userid == '' ? true : false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              child: Column(
                children: [
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(top: 15.0),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      width: MediaQuery.of(context).size.width * 0.99,
                      child: FittedBox(
                        child: Material(
                          color: Colors.white,
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(3.0),
                          shadowColor: Colors.grey,
                          child: Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.99,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red),
                                    child: Icon(
                                      Icons.account_box,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'My Account',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 23.0),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                    onTap: () {
                      print("tapped on container");
                    },
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(top: 15.0),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      width: MediaQuery.of(context).size.width * 0.99,
                      child: FittedBox(
                        child: Material(
                          color: Colors.white,
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(3.0),
                          shadowColor: Colors.grey,
                          child: Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.99,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green),
                                    child: Icon(
                                      Icons.lock,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Edit Password',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 23.0),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                    onTap: () {
                      print("tapped on container");
                    },
                  ),
                  Visibility(
                    visible: _isLogin,
                    child: InkWell(
                      child: Container(
                        margin: EdgeInsets.only(top: 15.0),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        width: MediaQuery.of(context).size.width * 0.99,
                        child: FittedBox(
                          child: Material(
                            color: Colors.white,
                            elevation: 2.0,
                            borderRadius: BorderRadius.circular(3.0),
                            shadowColor: Colors.grey,
                            child: Container(
                                padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width * 0.99,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black),
                                      child: Icon(
                                        Icons.login,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 23.0),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                      onTap: () {
                        var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new LoginPage());
                        Navigator.of(context).push(route);
                      },
                    ),
                  ),
                  Visibility(
                    visible: !_isLogin,
                    child: InkWell(
                      child: Container(
                        margin: EdgeInsets.only(top: 15.0),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        width: MediaQuery.of(context).size.width * 0.99,
                        child: FittedBox(
                          child: Material(
                            color: Colors.white,
                            elevation: 2.0,
                            borderRadius: BorderRadius.circular(3.0),
                            shadowColor: Colors.grey,
                            child: Container(
                                padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width * 0.99,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black),
                                      child: Icon(
                                        Icons.logout,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Logout',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 23.0),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Confirm'),
                            content:
                                const Text('Are you sure you want to Log out?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => signOut(),
                                child: const Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'no'),
                                child: const Text('No'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )),
        bottomNavigationBar: NavBar());
  }

  signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userid');
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('phone');
    await prefs.remove('shipping');
    await Future.delayed(Duration(seconds: 2));

    Navigator.of(context).pushAndRemoveUntil(
      // the new route
      MaterialPageRoute(
        builder: (BuildContext context) => DashboardPage(),
      ),
      (Route route) => false,
    );
  }
}
