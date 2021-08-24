import 'dart:convert';
import 'dart:io';
import 'package:fishRajkumar/components/Config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

String id = '';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

final _formKeyPUpdate = GlobalKey<FormState>();

class _MyProfilePageState extends State<MyProfilePage> {
  final title = 'My Profile';
  final TextEditingController _fname = TextEditingController();
  final TextEditingController _lname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _othersProfession = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  File _imageFile;
  final ImagePicker _picker = ImagePicker();

  String dropdownValue = 'Teacher';
  bool _isVisible = true;

  List data = List();
  String photo;
  @override
  void initState() {
    super.initState();
    this.profession();
    _incrementCounter();
    _isVisible = !_isVisible;
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = (prefs.getString('token'));
      _fname.text = (prefs.getString('first_name'));
      _lname.text = (prefs.getString('last_name'));
      _email.text = (prefs.getString('email'));
      _phone.text = (prefs.getString('phone'));
      dropdownValue = (prefs.getString('profession') != ''
          ? prefs.getString('profession')
          : 'Teacher');
      _othersProfession.text = (prefs.getString('other_profession'));
      photo =
          (prefs.getString('photo') != null ? prefs.getString('photo') : '');
      _isVisible = (dropdownValue == 'Others' ? true : false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.orange,
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
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
                        Padding(
                            padding: EdgeInsets.only(
                                top: 10.0,
                                right: 20.0,
                                bottom: 0.0,
                                left: 20.0),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.orange),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: CircleAvatar(
                                    radius: 80.0,
                                    backgroundImage: _imageFile == null
                                        ? NetworkImage(photo)
                                        : FileImage(File(_imageFile.path)),
                                  ),
                                ),
                                Positioned(
                                    bottom: 10.0,
                                    right: 10.0,
                                    child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: ((builder) => bottomSheet()),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.orange,
                                                spreadRadius: 3),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.orange,
                                            size: 28.0,
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            )),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 15.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'First Name',
                                    style: TextStyle(
                                      color: Colors.black87,
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
                                    color: Colors.black87, fontSize: 15.0),
                                decoration: InputDecoration(
                                    hintText: 'Enter your first name',
                                    hintStyle: TextStyle(
                                        fontSize: 15.0, color: Colors.black87),
                                    prefixIcon: const Icon(
                                      Icons.account_box_rounded,
                                      color: Colors.orange,
                                    ),
                                    border: InputBorder.none,
                                    filled: true,
                                    //fillColor: Colors.white,
                                    contentPadding: EdgeInsets.all(10.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                          color: Colors.orange, width: 2.0),
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
                                      color: Colors.black87,
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
                                    color: Colors.black87, fontSize: 15.0),
                                decoration: InputDecoration(
                                  hintText: 'Enter your last name',
                                  hintStyle: TextStyle(
                                      fontSize: 15.0, color: Colors.black87),
                                  prefixIcon: const Icon(
                                    Icons.account_box_rounded,
                                    color: Colors.orange,
                                  ),
                                  border: InputBorder.none,
                                  filled: true,
                                  //fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
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
                                      color: Colors.black87,
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
                                    color: Colors.black87, fontSize: 15.0),
                                decoration: InputDecoration(
                                    hintText: 'Enter your email',
                                    hintStyle: TextStyle(
                                        fontSize: 15.0, color: Colors.black87),
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.orange,
                                    ),
                                    border: InputBorder.none,
                                    filled: true,
                                    //fillColor: Colors.white,
                                    contentPadding: EdgeInsets.all(10.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                          color: Colors.orange, width: 2.0),
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
                                      color: Colors.black87,
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
                                controller: _phone,
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 15.0),
                                decoration: InputDecoration(
                                    hintText: 'Enter your phone',
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontSize: 15.0, color: Colors.black87),
                                    prefixIcon: const Icon(
                                      Icons.phone_android,
                                      color: Colors.orange,
                                    ),
                                    filled: true,
                                    //fillColor: Colors.orange,
                                    contentPadding: EdgeInsets.all(13.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                          color: Colors.orange, width: 2.0),
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
                                    'Profession',
                                    style: TextStyle(
                                      color: Colors.black87,
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
                                            width: 2.0, color: Colors.orange)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Icon(Icons.work,
                                                  color: Colors.orange)),
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
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                value: dropdownValue,
                                                icon: const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.black87),
                                                iconSize: 24,
                                                elevation: 16,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15.0),
                                                dropdownColor: Colors.white,
                                                items: data.map((item) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    child: new Text(item != null
                                                        ? item
                                                        : null),
                                                    value: item.toString(),
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  setState(() {
                                                    dropdownValue = (val != null
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
                                              color: Colors.black87,
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
                                              color: Colors.black87,
                                              fontSize: 15.0),
                                          decoration: InputDecoration(
                                            hintText: 'Others Profession',
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black87),
                                            prefixIcon: const Icon(
                                              Icons.workspaces_filled,
                                              color: Colors.orange,
                                            ),
                                            filled: true,
                                            //fillColor: Colors.orange,
                                            contentPadding:
                                                EdgeInsets.all(13.0),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.orange,
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
                                      profileUpdate(
                                          _fname.text,
                                          _lname.text,
                                          _email.text,
                                          _phone.text,
                                          dropdownValue,
                                          _othersProfession.text,
                                          _imageFile,
                                          id);
                                      //signIn(_email.text, _password.text);
                                    },
                                    padding: EdgeInsets.all(15.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.orange,
                                    child: Text(
                                      'SAVE CHANGES',
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 1.5,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
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

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            SizedBox(
              width: 20,
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    Navigator.pop(context);
    File picked = await ImagePicker.pickImage(source: source);
    if (picked != null) {
      _cropImage(picked);
    }
  }

  _cropImage(File picked) async {
    File cropped = await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
        statusBarColor: Colors.orange,
        toolbarColor: Colors.orange,
        toolbarTitle: "Crop Image",
        toolbarWidgetColor: Colors.white,
      ),
      sourcePath: picked.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio4x3,
      ],
      maxWidth: 800,
    );
    if (cropped != null) {
      setState(() {
        _imageFile = cropped;
      });
    }
  }

  profileUpdate(String fname, lname, email, phone, profession, otherProfession,
      photo, id) async {
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
        'id': id,
        'first_name': fname,
        'last_name': lname,
        'email': email,
        'phone': phone,
        'profession': profession,
        'other_profession': otherProfession,
        'photo_base64': photo != null
            ? 'data:image/png;base64,' + base64Encode(photo.readAsBytesSync())
            : ''
      };
      var jsonResponse;
      var response = await http
          .post(Uri.parse(Config.site_url + "account-setting.php"), body: data);
      jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        if (jsonResponse['result'] == "1") {
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Your profile details have been saved successfully."),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
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
              "profession", jsonResponse["user_data"]["profession"]);
          sharedPreferences.setString("other_profession",
              jsonResponse["user_data"]["other_profession"]);
          if (photo != null) {
            sharedPreferences.setString(
                "photo", jsonResponse["user_data"]["photo"]);
          }
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
