import 'package:flutter/material.dart';
import 'package:fishRajkumar/pages/ProductDetailPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var jsonResponse;
  List productList;
  bool isLoading = true;
  Future<void> getProductList() async {
    try {
      var response = await http.post(
        Uri.parse(
            'http://www.webpridesolution.com/fishrajkumar/public/api/getcategoryproducts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'category_id': '4',
        }),
      );

      if (response.statusCode == 200) {
        jsonResponse = jsonDecode(response.body);
        setState(() {
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
      appBar: buildAppBar(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              child: ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ProductDetailPage()),
                              (Route<dynamic> route) => false);
                        },
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
                                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                            productList[index]['image_path'])),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    width:
                                        MediaQuery.of(context).size.width * .6,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              productList[index]['name'],
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              productList[index]
                                                  ['sort_description'],
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: Row(
                                            children: [
                                              Text(
                                                '\u{20B9}' +
                                                    productList[index]
                                                        ['sell_price'],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '\u{20B9}' +
                                                    productList[index]
                                                        ['base_price'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 18,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 15,
                                                color: Colors.green,
                                              ),
                                              Text(
                                                "4",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                " ( 45 ratings )",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
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
                    );
                  }),
            ),
    );
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
