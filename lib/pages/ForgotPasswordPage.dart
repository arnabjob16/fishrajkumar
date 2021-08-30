import 'package:fishRajkumar/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fishRajkumar/components/config.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  bool _initCode = true;
  bool _newobscureText = true;
  bool _conobscureText = true;

  bool _codeTFVisible = false;
  bool _codeTLVisible = false;
  bool _newPassLblVisible = false;
  bool _newPassVisible = false;
  bool _conPassLblVisible = false;
  bool _conPassVisible = false;
  bool _vcBtnVisible = false;
  bool _submitbtnVisible = false;

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
                      Colors.orangeAccent.shade400,
                      Colors.orangeAccent.shade400,
                      Colors.orangeAccent.shade700,
                      Colors.orangeAccent.shade700,
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
                    vertical: 100.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Forgot Password',
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
                          Visibility(
                            visible: _initCode,
                            replacement: Container(),
                            child: Padding(
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
                          ),
                          Visibility(
                            visible: _initCode,
                            replacement: Container(),
                            child: Padding(
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
                          ),
                          Visibility(
                            visible: _initCode,
                            replacement: Container(),
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: ButtonTheme(
                                minWidth: double.infinity,
                                child: RaisedButton(
                                  elevation: 5.0,
                                  onPressed: () {
                                    setState(() {});
                                    verificationCode(_email.text);
                                  },
                                  padding: EdgeInsets.all(15.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  color: Colors.white,
                                  child: Text(
                                    'Get Verification Code',
                                    style: TextStyle(
                                      color: Color(0xFFE65100),
                                      letterSpacing: 1.5,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _codeTFVisible,
                            replacement: Container(),
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Verification Code',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'OpenSans',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                          ),
                          Visibility(
                            visible: _codeTFVisible,
                            replacement: Container(),
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: TextField(
                                controller: _code,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.white,
                                autocorrect: false,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                                decoration: InputDecoration(
                                    hintText: 'Verification Code',
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
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Visibility(
                              visible: _vcBtnVisible,
                              replacement: Container(),
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: ButtonTheme(
                                  minWidth: double.infinity,
                                  child: RaisedButton(
                                    elevation: 5.0,
                                    onPressed: () {
                                      verifyCode(_email.text, _code.text);
                                    },
                                    padding: EdgeInsets.all(15.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.white,
                                    child: Text(
                                      'Verify Code',
                                      style: TextStyle(
                                        color: Color(0xFFE65100),
                                        letterSpacing: 1.5,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _newPassLblVisible,
                            replacement: Container(),
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'New Password',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'OpenSans',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                          ),
                          Visibility(
                            visible: _newPassVisible,
                            replacement: Container(),
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: TextField(
                                autocorrect: false,
                                obscureText: _newobscureText,
                                controller: _newPassword,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.white,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                                decoration: InputDecoration(
                                    hintText: 'New Password',
                                    hintStyle: TextStyle(
                                        fontSize: 15.0, color: Colors.white),
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                    border: InputBorder.none,
                                    suffixIcon: new GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _newobscureText = !_newobscureText;
                                        });
                                      },
                                      child: new Icon(
                                        _newobscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.white,
                                      ),
                                    ),
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
                          ),
                          Visibility(
                            visible: _conPassLblVisible,
                            replacement: Container(),
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Confirm Password',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'OpenSans',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                          ),
                          Visibility(
                            visible: _conPassVisible,
                            replacement: Container(),
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: TextField(
                                autocorrect: false,
                                obscureText: _conobscureText,
                                controller: _confirmPassword,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.white,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                                decoration: InputDecoration(
                                    hintText: 'Confirm Password',
                                    hintStyle: TextStyle(
                                        fontSize: 15.0, color: Colors.white),
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                    border: InputBorder.none,
                                    suffixIcon: new GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _conobscureText = !_conobscureText;
                                        });
                                      },
                                      child: new Icon(
                                        _conobscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.white,
                                      ),
                                    ),
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
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 30),
                              child: Column(
                                children: <Widget>[
                                  Visibility(
                                    visible: _submitbtnVisible,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: ButtonTheme(
                                        minWidth: double.infinity,
                                        child: RaisedButton(
                                          elevation: 5.0,
                                          onPressed: () {
                                            changePassword(
                                                _email.text,
                                                _newPassword.text,
                                                _confirmPassword.text);
                                          },
                                          padding: EdgeInsets.all(15.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          color: Colors.white,
                                          child: Text(
                                            'Submit',
                                            style: TextStyle(
                                              color: Color(0xFFE65100),
                                              letterSpacing: 1.5,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _submitbtnVisible,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: ButtonTheme(
                                        minWidth: double.infinity,
                                        child: RaisedButton(
                                          elevation: 5.0,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          padding: EdgeInsets.all(15.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          color: Colors.white,
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Color(0xFFE65100),
                                              letterSpacing: 1.5,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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

  verificationCode(String email) async {
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
    if (e == null || e == '') {
      error = 1;
      errorMsg = 'Please enter your email or phone';
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
      Map data = {'email': email};
      var result = await http
          .post(Uri.parse(Config.site_url + "forget-password.php"), body: data);
      jsonResponse = json.decode(result.body);
      if (result.statusCode == 200) {
        if (jsonResponse['result'] == "1") {
          setState(() {
            _initCode = false;
            _codeTFVisible = true;
            _codeTLVisible = true;
            _vcBtnVisible = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(jsonResponse["msg"]),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(jsonResponse["msg"]),
            backgroundColor: Colors.red,
          ));
          Navigator.of(context).pop();
        }
      }
    }
  }

  verifyCode(String email, code) async {
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
    String c = code.replaceAll(new RegExp(r"\s+"), "");

    if (e == null || e == '') {
      error = 1;
      errorMsg = 'Please enter your email or phone';
    } else if (c == null || c == '') {
      errorMsg = 'Please enter the code';
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
      Map data = {'email': email, 'verification_code': code};
      var result = await http.post(
          Uri.parse(Config.site_url + "forget-password-submit.php"),
          body: data);
      jsonResponse = json.decode(result.body);
      if (result.statusCode == 200) {
        if (jsonResponse['result'] == "1") {
          setState(() {});
          _newPassLblVisible = true;
          _newPassVisible = true;
          _conPassLblVisible = true;
          _conPassVisible = true;
          _submitbtnVisible = true;

          _codeTFVisible = false;
          _codeTLVisible = false;
          _vcBtnVisible = false;
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(jsonResponse["msg"]),
            backgroundColor: Colors.red,
          ));
          Navigator.of(context).pop();
        }
      }
    }
  }

  changePassword(String email, newPass, conPass) async {
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
    String c = conPass.replaceAll(new RegExp(r"\s+"), "");
    String n = newPass.replaceAll(new RegExp(r"\s+"), "");
    bool hasUppercase = n.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = n.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = n.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        n.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = n.length > 5;
    if (e == null || e == '') {
      error = 1;
      errorMsg = 'Please enter your email or phone';
    } else if (n == null || n == '') {
      errorMsg = 'Please enter your password';
      error = 1;
    } else if (!hasDigits ||
        !hasUppercase ||
        !hasLowercase ||
        !hasSpecialCharacters ||
        !hasMinLength) {
      errorMsg =
          'Password must be 6 characters and contains one uppercase,lowercase,number and special character.';
      error = 1;
    } else if (c != n) {
      errorMsg = 'Passwords does not match';
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
      Map data = {'email': email, 'password': conPass};
      var result = await http
          .post(Uri.parse(Config.site_url + "change-password.php"), body: data);
      jsonResponse = json.decode(result.body);
      if (result.statusCode == 200) {
        Navigator.of(context).pop();
        if (jsonResponse['result'] == "1") {
          Navigator.of(context).pushAndRemoveUntil(
            // the new route
            MaterialPageRoute(
              builder: (BuildContext context) => LoginPage(),
            ),
            (Route route) => false,
          );
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(jsonResponse["msg"]),
              backgroundColor: Colors.green));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(jsonResponse["msg"]),
            backgroundColor: Colors.red,
          ));
          Navigator.of(context).pop();
        }
      }
    }
  }
}
