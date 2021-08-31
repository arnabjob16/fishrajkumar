import 'package:fishRajkumar/components/Header.dart';
import 'package:fishRajkumar/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:fishRajkumar/components/Config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fishRajkumar/pages/CartPage.dart';

enum BestTutorSite { gram, kg }

class ProductDetailPage extends StatefulWidget {
  final int value;
  const ProductDetailPage({Key key, @required this.value}) : super(key: key);
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  BestTutorSite _site = BestTutorSite.gram;
  String _quantityType = "GM";
  var totalPrice;
  var orginalPrice;
  final TextEditingController _quantity = TextEditingController();
  var jsonResponse;
  List productList;
  var productDetails;
  List imgList = [];
  bool isLoading = true;
  Future<void> getProductDetails() async {
    try {
      print(widget.value);
      var response = await http.post(
        Uri.parse(Config.site_url + 'getproductdetails'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'product_id': '2'}),
      );

      print(response);
      if (response.statusCode == 200) {
        jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        setState(() {
          print(response);
          productDetails = jsonResponse['data']['details'];
          imgList = productDetails['additionalimages'];
          orginalPrice = productDetails['sell_price'];
          isLoading = false;
        });

        print(productDetails);
      }
    } catch (e) {
      print("error:$e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.value);
    this.getProductDetails();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 15.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * .30,
                      child: Carousel(
                        autoplay: false,
                        showIndicator: true,
                        dotIncreasedColor: Colors.blueAccent,
                        dotBgColor: Colors.transparent,
                        dotSize: 5.0,
                        dotPosition: DotPosition.bottomCenter,
                        images: imgList
                            .map(
                              (item) => Container(
                                child: Center(
                                    child: Image.network(item['image_path'],
                                        fit: BoxFit.cover)),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          productDetails['name'],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '\u{20B9}' + productDetails['sell_price'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '\u{20B9}' + productDetails['price'],
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 15,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.green,
                            padding: EdgeInsets.all(7),
                            child: Text(
                              productDetails['discount_percent'] + "% off",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey, width: 1.0),
                          bottom: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              child: Text(
                                "Description",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: Colors.blueGrey),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(productDetails['description']),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Container(
                                padding: EdgeInsets.only(top: 15),
                                child: Text(
                                  "Choose Quantity",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17,
                                      color: Colors.blueAccent[700]),
                                ))),
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.blueAccent[700],
                                width: 2.0,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: TextField(
                                  onChanged: (text) {
                                    _getTotalPrice();
                                  },
                                  controller: _quantity,
                                  cursorColor: Colors.blueAccent,
                                  keyboardType: TextInputType.number,
                                  autocorrect: false,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15.0),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.blueAccent),
                                    border: InputBorder.none,
                                    filled: true,
                                    //fillColor: Colors.white,
                                    contentPadding: EdgeInsets.all(10.0),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height: 48.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white70,
                                      border: Border(
                                          top: BorderSide(
                                              width: 0,
                                              color: Colors.blueAccent),
                                          right: BorderSide(
                                              width: 0,
                                              color: Colors.blueAccent),
                                          bottom: BorderSide(
                                              width: 0,
                                              color: Colors.blueAccent))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      isDense: true,
                                      value: _quantityType,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _quantityType = newValue;
                                        });
                                        _getTotalPrice();
                                      },
                                      items: <String>['GM', 'KG']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      color: Colors.blueAccent[700],
                      padding: EdgeInsets.all(6),
                      child: Text(
                        "Total Amount",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width / 2,
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  onPressed: _addToCart,
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width / 2,
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  onPressed: () {},
                  color: Colors.white,
                  textColor: Colors.blueAccent,
                  child: Text(
                    'Buy Now',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addToCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('userid');
    if (userid == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else {
      try {
        setState(() {
          isLoading = true;
        });
        var response = await http.post(
          Uri.parse(Config.site_url + 'addtocart'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'user_id': userid,
            'product_id': productDetails['id'].toString(),
            'weight': _quantity.text,
            'weight_unit': _quantityType,
            'price': productDetails['sell_price'],
            'total_price': totalPrice
          }),
        );

        print(response);
        if (response.statusCode == 200) {
          jsonResponse = jsonDecode(response.body);
          print(jsonResponse);
          setState(() {
            isLoading = false;
          });

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => CartPage()),
              (Route<dynamic> route) => false);
        }
      } catch (e) {
        print("error:$e");
      }
    }
  }

  void _getTotalPrice() async {
    print("@1");
    var amount = double.parse(_quantity.text);
    print(amount);
    if (_quantityType == 'GM') {
      amount = amount / 1000;
    }
    print(amount);
    double calculatedPrice = amount * double.parse(orginalPrice);
    //print(calculatedPrice);
    var a = calculatedPrice.toStringAsFixed(2);
    print(a);
    setState(() {
      totalPrice = a;
    });

    // print(totalPrice);
  }
}
