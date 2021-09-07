import 'dart:convert';
import 'package:fishRajkumar/components/Config.dart';
import 'package:fishRajkumar/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

final _formKeysignup = GlobalKey<FormState>();

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  List data = List();
  bool _obscureText = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blueAccent.shade400,
                      Colors.blueAccent.shade400,
                      Colors.blueAccent.shade700,
                      Colors.blueAccent.shade700,
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 30.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Form(
                          key: _formKeysignup,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 15.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'OpenSans',
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: TextField(
                                  autocorrect: false,
                                  controller: _name,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                  decoration: InputDecoration(
                                      hintText: 'Enter your name',
                                      hintStyle: TextStyle(
                                          fontSize: 15.0, color: Colors.white),
                                      prefixIcon: const Icon(
                                        Icons.account_box_rounded,
                                        color: Colors.white,
                                      ),
                                      border: InputBorder.none,
                                      filled: true,
                                      //fillColor: Colors.white,
                                      contentPadding: EdgeInsets.all(10.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide: BorderSide(
                                            color: Colors.greenAccent[200],
                                            width: 2.0),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 12.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Email',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'OpenSans',
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: TextField(
                                  autocorrect: false,
                                  controller: _email,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                  decoration: InputDecoration(
                                      hintText: 'Enter your email',
                                      hintStyle: TextStyle(
                                          fontSize: 15.0, color: Colors.white),
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                      border: InputBorder.none,
                                      filled: true,
                                      //fillColor: Colors.white,
                                      contentPadding: EdgeInsets.all(10.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide: BorderSide(
                                            color: Colors.greenAccent[200],
                                            width: 2.0),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 12.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Password',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'OpenSans',
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: TextField(
                                  autocorrect: false,
                                  cursorColor: Colors.white,
                                  obscureText: _obscureText,
                                  controller: _password,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                  decoration: InputDecoration(
                                      hintText: 'Password',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          fontSize: 15.0, color: Colors.white),
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                      suffixIcon: new GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                        child: new Icon(
                                          _obscureText
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.white,
                                        ),
                                      ),
                                      filled: true,
                                      //fillColor: Colors.orange,
                                      contentPadding: EdgeInsets.all(13.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide: BorderSide(
                                            color: Colors.greenAccent[200],
                                            width: 2.0),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 12.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Phone',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'OpenSans',
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                            width: 2.0, color: Colors.white)),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: TextField(
                                            autocorrect: false,
                                            controller: _phone,
                                            keyboardType: TextInputType.phone,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0),
                                            decoration: InputDecoration(
                                              hintText: 'Enter your phone',
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white),

                                              filled: true,
                                              prefixIcon: const Icon(
                                                Icons.phone_android,
                                                color: Colors.white,
                                              ),
                                              //fillColor: Colors.orange,
                                              contentPadding:
                                                  EdgeInsets.all(13.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(top: 30.0),
                                  child: ButtonTheme(
                                    minWidth: double.infinity,
                                    child: RaisedButton(
                                      elevation: 5.0,
                                      onPressed: () {
                                        setState(() {});
                                        signUp(
                                          _name.text,
                                          _email.text,
                                          _password.text,
                                          _phone.text,
                                        );
                                        //signIn(_email.text, _password.text);
                                      },
                                      padding: EdgeInsets.all(15.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      color: Colors.white,
                                      child: Text(
                                        'SIGNUP',
                                        style: TextStyle(
                                          color: Colors.blueAccent[700],
                                          letterSpacing: 1.5,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'OpenSans',
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  signUp(String name, email, pass, phone) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            child: Padding(
          padding: EdgeInsets.all(20.0),
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new SizedBox(
                width: 10.0,
              ),
              new Text("Loading"),
            ],
          ),
        ));
      },
    );
    int error = 0;
    String errorMsg;
    String na = name.replaceAll(new RegExp(r"\s+"), "");
    String em = email.replaceAll(new RegExp(r"\s+"), "");
    String pa = pass.replaceAll(new RegExp(r"\s+"), "");
    if (na == null || na == '') {
      error = 1;
      errorMsg = 'Please enter your first name';
    } else if (em == null || em == '') {
      errorMsg = 'Please enter your email';
      error = 1;
    } else if (pa == null || pa == '') {
      errorMsg = 'Please enter your password';
      error = 1;
    }
    if (error == 1) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMsg),
        backgroundColor: Colors.red,
      ));
      Navigator.of(context).pop();
    } else {
      var jsonResponse;
      var response = await http.post(
        Uri.parse(Config.site_url + 'register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password': pass,
          'mobile': phone,
        }),
      );

      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
        if (jsonResponse['success'] == true) {
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(jsonResponse["message"]),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
              (Route<dynamic> route) => false);
        } else {
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(jsonResponse["message"]),
            backgroundColor: Colors.red,
          ));
          Navigator.of(context).pop();
        }
      } else {
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonResponse["message"]),
          backgroundColor: Colors.red,
        ));
        Navigator.of(context).pop();
      }
    }
  }
}
