import 'dart:ui';

import 'package:fishRajkumar/components/Header.dart';
import 'package:flutter/material.dart';
import 'package:fishRajkumar/pages/ProductDetailPage.dart';
import 'package:fishRajkumar/pages/OrderDetailsPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fishRajkumar/components/Config.dart';
import 'package:fishRajkumar/components/NavBar.dart';
import 'package:fishRajkumar/pages/CartPage.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  var jsonResponse;
  List productList;
  bool isLoading = true;
  Future<void> getProductList() async {
    try {
      var response = await http.post(
        Uri.parse(Config.site_url + 'getcategoryproducts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'category_id': '4'}),
      );

      print(response);
      if (response.statusCode == 200) {
        jsonResponse = jsonDecode(response.body);
        setState(() {
          print(response);
          productList = jsonResponse['products'];
          isLoading = false;
        });

        print(productList);
      }
    } catch (e) {
      print("error:$e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 15.0),
                child: ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ProductDetailPage(
                                            value: productList[index]['id'])),
                                (Route<dynamic> route) => false);
                          },
                          child: Card(
                            elevation: 3, // Change this
                            shadowColor: Colors.black87,
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(10),
                                    decoration:
                                        BoxDecoration(color: Colors.grey[200]),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        "Placed on wed, 1 Sep, 8:40 AM",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "2 items",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          '\u{20B9} 500',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 10),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "Scheduled for ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "Thu, 2 Sep, 9 AM - 1 PM",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      )),
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 10),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Order id : ORD12345678",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.check,
                                          color: Colors.greenAccent,
                                          size: 25,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Delivered",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  OrderDetailsPage()),
                                          (Route<dynamic> route) => true);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.redAccent),
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "View Details",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 2),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ));
                    }),
              ),
        bottomNavigationBar: NavBar());
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.grey[800],
        ),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.grey[800],
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.grey[800],
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
