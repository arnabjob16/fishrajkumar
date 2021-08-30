import 'dart:convert';
import 'package:fishRajkumar/components/Config.dart';
import 'package:fishRajkumar/pages/ForgotPasswordPage.dart';
import 'package:fishRajkumar/pages/RegisterPage.dart';
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
                          Image.asset(
                            "assets/logos/logo.png",
                            fit: BoxFit.cover,
                            //color: Colors.black,
                            colorBlendMode: BlendMode.color,
                            width: 100,
                            height: 100,
                          ),
                        ],
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
                                        var route = new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new ForgotPasswordPage());
                                        Navigator.of(context).push(route);
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
                                      onTap: () {
                                        var route = new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new RegisterPage());
                                        Navigator.of(context).push(route);
                                      })
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
      var jsonResponse;
      var loginData;
      var response = await http.post(
        Uri.parse(Config.site_url + 'login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{'logininput': email, 'password': pass}),
      );
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
        if (jsonResponse['success'] == true) {
          setState(() {
            loginData = jsonResponse['data']['user_data'];
          });
          sharedPreferences.setString("userid", loginData["id"].toString());
          sharedPreferences.setString("name", loginData["name"]);
          //sharedPreferences.setString(
          //    "profile_image", loginData["profile_image"]);
          sharedPreferences.setString("email", loginData["email"]);
          sharedPreferences.setString("phone", loginData["mobile"]);
          sharedPreferences.setString(
              "shipping", jsonResponse['data']['shipping_charge']);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
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
          content: Text(jsonResponse["msg"]),
          backgroundColor: Colors.red,
        ));
        Navigator.of(context).pop();
      }
    }
  }
}
