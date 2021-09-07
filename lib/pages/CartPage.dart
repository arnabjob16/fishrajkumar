import 'package:fishRajkumar/components/Header.dart';
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
                                              .8,
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
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                      child: Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 5, 20, 0),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border(
                                                              bottom:
                                                                  BorderSide(
                                                                color: Colors
                                                                        .blueAccent[
                                                                    700],
                                                                width: 2.0,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.4,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            10.0),
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      _quantity,
                                                                  cursorColor:
                                                                      Colors
                                                                          .blueAccent,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  autocorrect:
                                                                      false,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blueAccent,
                                                                      fontSize:
                                                                          15.0),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                            15.0,
                                                                        color: Colors
                                                                            .blueAccent),
                                                                    hintText:
                                                                        'Choose quantity',
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    filled:
                                                                        true,
                                                                    //fillColor: Colors.white,
                                                                    contentPadding:
                                                                        EdgeInsets.all(
                                                                            10.0),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 48.0,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.30,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            10.0),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white70,
                                                                    border: Border(
                                                                        top: BorderSide(
                                                                            width:
                                                                                0,
                                                                            color: Colors
                                                                                .blueAccent),
                                                                        right: BorderSide(
                                                                            width:
                                                                                0,
                                                                            color: Colors
                                                                                .blueAccent),
                                                                        bottom: BorderSide(
                                                                            width:
                                                                                0,
                                                                            color:
                                                                                Colors.blueAccent))),
                                                                child:
                                                                    DropdownButtonHideUnderline(
                                                                  child:
                                                                      DropdownButton<
                                                                          String>(
                                                                    isExpanded:
                                                                        true,
                                                                    isDense:
                                                                        true,
                                                                    value:
                                                                        _quantityType,
                                                                    onChanged:
                                                                        (String
                                                                            newValue) {
                                                                      setState(
                                                                          () {
                                                                        _quantityType =
                                                                            newValue;
                                                                      });
                                                                    },
                                                                    items: <
                                                                        String>[
                                                                      'GM',
                                                                      'KG'
                                                                    ].map<
                                                                        DropdownMenuItem<
                                                                            String>>((String
                                                                        value) {
                                                                      return DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            value,
                                                                        child: Text(
                                                                            value),
                                                                      );
                                                                    }).toList(),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )))
                                                ],
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
                                                    Row(
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
                                                          color: Colors.red,
                                                          splashColor:
                                                              Colors.purple,
                                                          onPressed: () {
                                                            setState(() {
                                                              isLoading = true;
                                                            });
                                                            removeCart(productList[
                                                                    index][
                                                                'cart_row_id']);
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        )
                                                      ],
                                                    )
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
