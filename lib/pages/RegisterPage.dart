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
  final TextEditingController _fname = TextEditingController();
  final TextEditingController _lname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  //Getting the password from the textField
  final TextEditingController _password = TextEditingController();
  final TextEditingController _othersProfession = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  String _countryCode = '+1';

  String dropdownValue = 'Teacher';
  bool _isVisible = true;

  List data = List();

  @override
  void initState() {
    super.initState();
    this.profession();
    _isVisible = !_isVisible;
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
                    vertical: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
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
                                      'First Name',
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
                                  controller: _fname,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                  decoration: InputDecoration(
                                      hintText: 'Enter your first name',
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
                                      'Last Name',
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
                                  controller: _lname,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                  decoration: InputDecoration(
                                    hintText: 'Enter your last name',
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
                                    ),
                                  ),
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
                                padding: EdgeInsets.only(top: 8.0),
                                child: TextField(
                                  autocorrect: false,
                                  controller: _password,
                                  obscureText: true,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                  decoration: InputDecoration(
                                      hintText: 'Enter your password',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          fontSize: 15.0, color: Colors.white),
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Colors.white,
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
                                padding: EdgeInsets.only(top: 12.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Profession',
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Icon(Icons.work,
                                                    color: Colors.white)),
                                            new Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.60,
                                                child:
                                                    DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                  hint: Text(
                                                    dropdownValue,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  value: dropdownValue,
                                                  icon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.white),
                                                  iconSize: 24,
                                                  elevation: 16,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.0),
                                                  dropdownColor: Colors.grey,
                                                  items: data.map((item) {
                                                    return new DropdownMenuItem<
                                                        String>(
                                                      child: new Text(
                                                          item != null
                                                              ? item
                                                              : null),
                                                      value: item.toString(),
                                                    );
                                                  }).toList(),
                                                  onChanged: (val) {
                                                    setState(() {
                                                      dropdownValue =
                                                          (val != null
                                                              ? val
                                                              : dropdownValue);
                                                      if (dropdownValue ==
                                                          'Others') {
                                                        _isVisible = true;
                                                      } else {
                                                        _isVisible = false;
                                                      }
                                                    });
                                                  },
                                                )))
                                          ]))),
                              Visibility(
                                  visible: _isVisible,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 12.0),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Others Profession',
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
                                            controller: _othersProfession,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0),
                                            decoration: InputDecoration(
                                              hintText: 'Others Profession',
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white),
                                              prefixIcon: const Icon(
                                                Icons.workspaces_filled,
                                                color: Colors.white,
                                              ),
                                              filled: true,
                                              //fillColor: Colors.orange,
                                              contentPadding:
                                                  EdgeInsets.all(13.0),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 2.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.greenAccent[200],
                                                    width: 2.0),
                                              ),
                                            )),
                                      ),
                                    ],
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
                                            _fname.text,
                                            _lname.text,
                                            _email.text,
                                            _password.text,
                                            _phone.text,
                                            dropdownValue,
                                            _othersProfession.text,
                                            _countryCode);
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
                                          color: Color(0xFFE65100),
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

  Future<List<dynamic>> profession() async {
    var jsonResponse;
    var result = await http.get(Uri.parse(Config.site_url + "profession.php"));
    jsonResponse = json.decode(result.body);
    if (result.statusCode == 200) {
      if (jsonResponse['result'] == 1) {
        setState(() {
          data = jsonResponse['data'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonResponse["msg"]),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(jsonResponse["msg"]),
      ));
    }
  }

  signUp(String fname, lname, email, pass, phone, profession, otherProfession,
      countryCode) async {
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
    String fn = fname.replaceAll(new RegExp(r"\s+"), "");
    String ln = lname.replaceAll(new RegExp(r"\s+"), "");
    String em = email.replaceAll(new RegExp(r"\s+"), "");
    String pa = pass.replaceAll(new RegExp(r"\s+"), "");
    String pr = profession.replaceAll(new RegExp(r"\s+"), "");
    String ot = otherProfession.replaceAll(new RegExp(r"\s+"), "");
    if (fn == null || fn == '') {
      error = 1;
      errorMsg = 'Please enter your first name';
    } else if (ln == null || ln == '') {
      errorMsg = 'Please enter your last name';
      error = 1;
    } else if (em == null || em == '') {
      errorMsg = 'Please enter your email';
      error = 1;
    } else if (pa == null || pa == '') {
      errorMsg = 'Please enter your password';
      error = 1;
    } else if (pr == null || pr == '') {
      errorMsg = 'Please select your profession';
      error = 1;
    } else if (pr == 'Others' && (ot == null || ot == '')) {
      errorMsg = 'Please select your profession';
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
      Map data = {
        'first_name': fname,
        'last_name': lname,
        'email': email,
        'password': pass,
        'phone': countryCode + ' ' + phone,
        'profession': profession,
        'other_profession': otherProfession
      };
      var jsonResponse;
      var response = await http
          .post(Uri.parse(Config.site_url + "register.php"), body: data);
      jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        if (jsonResponse['result'] == "1") {
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("You have successfully registered."),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
              (Route<dynamic> route) => false);
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
