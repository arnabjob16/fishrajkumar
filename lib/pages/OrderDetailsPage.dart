import 'package:fishRajkumar/components/Header.dart';
import 'package:fishRajkumar/pages/AddressListPage.dart';
import 'package:flutter/material.dart';
import 'package:fishRajkumar/components/Config.dart';
import 'package:fishRajkumar/components/NavBar.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

double shipping;
var userid = '';
var email = '';
var phone = '';
double subtotal = 0.00;
double alltotal = 0.00;
String defaultaddress = '';

class OrderDetailsPage extends StatefulWidget {
  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  List cartProduct = [];
  bool cartProductLoading = true;
  String defaultaddress = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(30.0, 20.0, 10.0, 10.0),
                child: Text(
                  "Checkout",
                  style: TextStyle(
                      color: Colors.blueAccent[700],
                      fontWeight: FontWeight.w700,
                      fontSize: 25.0),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                //height: 520.0,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          var route = new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new OrderDetailsPage());
                          Navigator.of(context).push(route);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15.0),
                          child: FittedBox(
                            child: Material(
                              color: Colors.white,
                              elevation: 2.0,
                              borderRadius: BorderRadius.circular(3.0),
                              shadowColor: Colors.grey,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    height:
                                        MediaQuery.of(context).size.height / 8,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: new Image.network(
                                          'https://www.webpridesolution.com/app_images/product/BAIM-BIG-FISH-2-3-PCS-KG.jpg',
                                        )),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "ABC D",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .blueAccent[700],
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15.0),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              color: Colors.blueAccent[700],
                                              padding: EdgeInsets.all(6),
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '\u{20B9} 250',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14.0),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3.0,
                                        ),
                                        Container(
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "20 KG",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                child: Text(
                  "Address",
                  style: TextStyle(
                      color: Colors.blueAccent[700],
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                child: Text(
                  defaultaddress,
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                child: FractionallySizedBox(
                  widthFactor:
                      1, // means 100%, you can change this to 0.8 (80%)
                  child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(3.0),
                    ),
                    color: Colors.blueAccent[700],
                    onPressed: () {
                      AddressListPage();
                    },
                    label: Text('Change & Add Address',
                        style: TextStyle(color: Colors.white)),
                    icon: Icon(Icons.home, color: Colors.white),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                  padding: EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black45,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Subtotal",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0),
                          ),
                          Text(
                            '\u{20B9} 100',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0),
                          )
                        ],
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Shipping",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0),
                          ),
                          Text(
                            '\u{20B9} 200',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0),
                          )
                        ],
                      ),
                    ],
                  )),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Total",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0),
                          ),
                          Text(
                            '\u{20B9} 500',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0),
                          )
                        ],
                      ),
                      SizedBox(height: 15.0),
                      FractionallySizedBox(
                        widthFactor:
                            1, // means 100%, you can change this to 0.8 (80%)
                        child: RaisedButton.icon(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(3.0),
                          ),
                          color: Colors.blueAccent[700],
                          onPressed: () {},
                          label: Text('Pay Now',
                              style: TextStyle(color: Colors.white)),
                          icon: Icon(Icons.lock, color: Colors.white),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        bottomNavigationBar: NavBar());
  }
}
