import 'dart:convert';
import 'package:fishRajkumar/components/Config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _email = TextEditingController();
  //Getting the password from the textField
  final TextEditingController _password = TextEditingController();
  final TextEditingController _guestTextFeild = TextEditingController();
  bool _obscureText = true;

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
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Email or Phone',
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
                              controller: _email,
                              cursorColor: Colors.white,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0),
                              decoration: InputDecoration(
                                  hintText: 'Email or Phone',
                                  hintStyle: TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                  prefixIcon: const Icon(
                                    Icons.account_box,
                                    color: Colors.white,
                                  ),
                                  border: InputBorder.none,
                                  filled: true,
                                  //fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                        color: Colors.greenAccent[200],
                                        width: 2.0),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                        color: Colors.greenAccent[200],
                                        width: 2.0),
                                  )),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  GestureDetector(
                                      child: Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                          fontFamily: 'OpenSans',
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      onTap: () {
                                        ;
                                      }),
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: ButtonTheme(
                              minWidth: double.infinity,
                              child: RaisedButton(
                                elevation: 5.0,
                                onPressed: () {
                                  setState(() {});
                                  signIn(_email.text, _password.text);
                                },
                                padding: EdgeInsets.all(15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Colors.white,
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.blueAccent[700],
                                    letterSpacing: 1.5,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 30.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Don't have an account? ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'OpenSans',
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  GestureDetector(
                                      child: Text(
                                        "SingUp",
                                        style: TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                          fontFamily: 'OpenSans',
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      onTap: () {})
                                ],
                              )),
                        ],
                      )
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

  signIn(String email, pass) async {
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
    String e = email.replaceAll(new RegExp(r"\s+"), "");
    String p = pass.replaceAll(new RegExp(r"\s+"), "");
    if (e == null || e == '') {
      error = 1;
      errorMsg = 'Please enter your email or phone';
    } else if (p == null || p == '') {
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
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      Map data = {'email': email, 'password': pass};
      var jsonResponse;
      var response =
          await http.post(Uri.parse(Config.site_url + "login.php"), body: data);
      jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        if (jsonResponse['result'] == 1) {
          setState(() {});
          sharedPreferences.setString("token", jsonResponse["user_data"]["id"]);
          sharedPreferences.setString(
              "name", jsonResponse["user_data"]["name"]);
          sharedPreferences.setString(
              "first_name", jsonResponse["user_data"]["first_name"]);
          sharedPreferences.setString(
              "last_name", jsonResponse["user_data"]["last_name"]);
          sharedPreferences.setString(
              "email", jsonResponse["user_data"]["email"]);
          sharedPreferences.setString(
              "phone", jsonResponse["user_data"]["phone"]);
          sharedPreferences.setString(
              "countryCode", jsonResponse["user_data"]["country_code"]);
          sharedPreferences.setString(
              "profession", jsonResponse["user_data"]["profession"]);
          sharedPreferences.setString("other_profession",
              jsonResponse["user_data"]["other_profession"]);
          sharedPreferences.setString(
              "photo", jsonResponse["user_data"]["photo"]);
          sharedPreferences.setString(
              "refer_text", jsonResponse["user_data"]["refer_text"]);
          sharedPreferences.setString(
              "refer_link", jsonResponse["user_data"]["refer_link"]);

          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => DashboardPage()),
          //     (Route<dynamic> route) => false);
        } else {
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(jsonResponse["msg"]),
            backgroundColor: Colors.red,
          ));
          Navigator.of(context).pop();
        }
      } else {
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonResponse["msg"]),
          backgroundColor: Colors.red,
        ));
        Navigator.of(context).pop();
      }
    }
  }
}
