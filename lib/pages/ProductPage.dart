import 'package:fishRajkumar/components/Header.dart';
import 'package:flutter/material.dart';
import 'package:fishRajkumar/pages/ProductDetailPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fishRajkumar/components/Config.dart';
import 'package:fishRajkumar/components/NavBar.dart';
import 'package:fishRajkumar/pages/CartPage.dart';

class ProductPage extends StatefulWidget {
  final int value;
  const ProductPage({Key key, @required this.value}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var jsonResponse;
  List productList;
  bool isLoading = true;
  Future<void> getProductList() async {
    try {
      print(widget.value);
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
    print(widget.value);
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
                              onTap: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ProductDetailPage(
                                                value: productList[index]
                                                    ['id'])),
                                    (Route<dynamic> route) => false);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 15.0),
                                child: FittedBox(
                                  child: Material(
                                    color: Colors.white,
                                    elevation: 3.0,
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
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    productList[index]['name'],
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors
                                                            .blueAccent[700],
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 6.0,
                                              ),
                                              Container(
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    productList[index]
                                                                    [
                                                                    'sort_description']
                                                                .length >
                                                            3
                                                        ? productList[index][
                                                                    "sort_description"]
                                                                .substring(
                                                                    0, 50) +
                                                            '...'
                                                        : productList[index][
                                                            "sort_description"],
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
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 5, 0, 0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '\u{20B9}' +
                                                          productList[index]
                                                              ['sell_price'],
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 14.0),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '\u{20B9}' +
                                                          productList[index]
                                                              ['base_price'],
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Container(
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    '${productList[index]["discount_percent"]}% off',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                ),
                                              )
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
