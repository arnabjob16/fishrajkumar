import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fishRajkumar/components/Config.dart';
import 'package:fishRajkumar/components/NavBar.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String _quantityType = "GM";
  final TextEditingController _quantity = TextEditingController();
  var jsonResponse;
  List productList;
  bool isLoading = true;
  Future<void> getProductList() async {
    try {
      var response = await http.post(
        Uri.parse(Config.site_url + 'getcartdetails'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'user_id': '1'}),
      );

      print(response);
      if (response.statusCode == 200) {
        jsonResponse = jsonDecode(response.body);
        setState(() {
          print(response);
          productList = jsonResponse['data']['cartdata'];
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(130.0),
          // here the desired height
          child: AppBar(
            automaticallyImplyLeading: false, // hides leading widget
            flexibleSpace: Column(children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Image.asset(
                  //   "assets/logos/logo.png",
                  //   fit: BoxFit.cover,
                  //   height: 60,
                  // ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.26,
                        ),
                        Text("Fish ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0)),
                        Text("Rajkumar",
                            style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0))
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: new Icon(Icons.shopping_cart_outlined,
                            color: Colors.white, size: 27.0),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: new Icon(Icons.notifications_none_rounded,
                            color: Colors.white, size: 27.0),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 40.0,
                  child: new GestureDetector(
                    onTap: () {
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Pressed"),
                        backgroundColor: Colors.blueAccent[700],
                      ));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black45, // red as border color.
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300],
                              blurRadius: 3.0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(Icons.search),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Search for Items, Categories',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.0,
                                  color: Colors.black54),
                            )
                          ],
                        )),
                  )),
            ]),
            backgroundColor: Colors.blueAccent[200],
          ),
        ),
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
                      return Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                margin: EdgeInsets.only(bottom: 15.0),
                                child: FittedBox(
                                  child: Material(
                                    color: Colors.white,
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(8.0),
                                    shadowColor: Colors.grey,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                  productList[index]
                                                      ['image_path'])),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .6,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    productList[index]
                                                        ['product_name'],
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                child: TextField(
                                                  controller: _quantity,
                                                  cursorColor:
                                                      Colors.blueAccent,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  autocorrect: false,
                                                  style: TextStyle(
                                                      color: Colors.blueAccent,
                                                      fontSize: 15.0),
                                                  decoration: InputDecoration(
                                                      hintText: 'Quantity',
                                                      hintStyle: TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors
                                                              .blueAccent),
                                                      border: InputBorder.none,
                                                      filled: true,
                                                      //fillColor: Colors.white,
                                                      contentPadding:
                                                          EdgeInsets.all(10.0),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .blueAccent,
                                                            width: 2.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .blueAccent,
                                                            width: 2.0),
                                                      )),
                                                ),
                                              ),
                                              Container(
                                                height: 48.0,
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.white70,
                                                    border: Border(
                                                        top: BorderSide(
                                                            width: 2.0,
                                                            color: Colors
                                                                .blueAccent),
                                                        right: BorderSide(
                                                            width: 2.0,
                                                            color: Colors
                                                                .blueAccent),
                                                        left: BorderSide(
                                                            width: 2.0,
                                                            color: Colors
                                                                .blueAccent),
                                                        bottom: BorderSide(
                                                            width: 2.0,
                                                            color: Colors
                                                                .blueAccent))),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    isExpanded: true,
                                                    isDense: true,
                                                    value: _quantityType,
                                                    onChanged:
                                                        (String newValue) {
                                                      setState(() {
                                                        _quantityType =
                                                            newValue;
                                                      });
                                                    },
                                                    items: <String>[
                                                      'GM',
                                                      'KG'
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 5, 0, 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '\u{20B9}' +
                                                          productList[index]
                                                              ['total_price'],
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      productList[index][
                                                              'discount_percent'] +
                                                          "% off",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.edit,
                                                      ),
                                                      iconSize: 30,
                                                      color: Colors.green,
                                                      splashColor:
                                                          Colors.purple,
                                                      onPressed: () {},
                                                    ),
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.delete,
                                                      ),
                                                      iconSize: 30,
                                                      color: Colors.green,
                                                      splashColor:
                                                          Colors.purple,
                                                      onPressed: () {
                                                        setState(() {
                                                          isLoading = true;
                                                        });
                                                        removeCart(productList[
                                                                index]
                                                            ['cart_row_id']);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
        bottomNavigationBar: NavBar());
  }

  void removeCart(int cart_id) async {
    try {
      var response = await http.post(
        Uri.parse(Config.site_url + 'removecart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'cart_row_id': cart_id.toString()}),
      );

      print(response);
      if (response.statusCode == 200) {
        getProductList();
      }
    } catch (e) {
      print("error:$e");
    }
  }
}
