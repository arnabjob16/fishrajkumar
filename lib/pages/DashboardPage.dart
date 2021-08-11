import 'dart:convert';
import 'package:fishRajkumar/pages/CheckoutPage.dart';
import 'package:fishRajkumar/pages/LoginPage.dart';
import 'package:fishRajkumar/pages/ProductPage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:fishRajkumar/components/Config.dart';
import 'package:fishRajkumar/components/NavBar.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  void initState() {
    super.initState();
    getbannersimage();
    getcategory();
    getfeaturedproduct();
    gettodaysdealproduct();
  }

  List bannerImage = [];
  bool bannerLoading = true;
  List productCategories = [];
  bool categoriesLoading = true;
  List todaysdealproduct = [];
  bool todaysdealLoading = true;

  List featuredproduct = [];
  bool featuredproductLoading = true;

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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width * 0.95,
                child: bannerLoading
                    ? CircularProgressIndicator()
                    : Carousel(
                        boxFit: BoxFit.cover,
                        autoplay: true,
                        animationCurve: Curves.fastOutSlowIn,
                        animationDuration: Duration(milliseconds: 1000),
                        dotSize: 6.0,
                        dotIncreasedColor: Color(0xFFFF335C),
                        dotBgColor: Colors.transparent,
                        dotPosition: DotPosition.bottomCenter,
                        dotVerticalPadding: 10.0,
                        showIndicator: true,
                        indicatorBgPadding: 7.0,
                        images: bannerImage.map((element) {
                          return new Image.network(element['image_path']);
                        }).toList(),
                      ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(children: <Widget>[
                      SizedBox(width: 5.0),
                      Text("Featured ",
                          style: TextStyle(
                              color: Colors.blueAccent[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                      Text("Categories",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0))
                    ]),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('View all')),
                ],
              ),
              SizedBox(
                  child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 260.0,
                child: GridView.count(
                  physics: ScrollPhysics(),
                  crossAxisCount: 3,
                  children: List.generate(productCategories.length, (index) {
                    return categoriesLoading
                        ? CircularProgressIndicator()
                        : Card(
                            elevation: 3, // Change this
                            shadowColor: Colors.black87,
                            child: Container(
                              width: double.infinity,
                              height: 100.0,
                              child: new Image.network(
                                  productCategories[index]['image_path']),
                            ));
                  }),
                ),
              )),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(children: <Widget>[
                      SizedBox(width: 5.0),
                      Text("Featured ",
                          style: TextStyle(
                              color: Colors.blueAccent[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                      Text("Products",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0))
                    ]),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('View all')),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 220.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(8),
                  itemCount: featuredproduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.43,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                          child: Card(
                              elevation: 3, // Change this
                              shadowColor: Colors.black87,
                              child: Container(
                                  width: double.infinity,
                                  height: 100.0,
                                  child: Column(
                                    children: <Widget>[
                                      Center(
                                        child: new Image.network(
                                            featuredproduct[index]
                                                ["image_path"]),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 12.0,
                                          ),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Flexible(
                                                      child: Container(
                                                          padding:
                                                              new EdgeInsets
                                                                      .only(
                                                                  right: 10.0),
                                                          child: new Text(
                                                            featuredproduct[
                                                                index]["name"],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black38,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14.0),
                                                          )))
                                                ],
                                              )),
                                          SizedBox(
                                            height: 6.0,
                                          ),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Text(
                                                    '\u{20B9} ' +
                                                        featuredproduct[index]
                                                            ["sell_price"],
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14.0),
                                                  ),
                                                  SizedBox(
                                                    width: 3.0,
                                                  ),
                                                  Text(
                                                    '\u{20B9} ' +
                                                        featuredproduct[index]
                                                            ["base_price"],
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12.0,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                  ),
                                                  SizedBox(
                                                    width: 3.0,
                                                  ),
                                                  Text(
                                                    '20% off',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 11.0,
                                                    ),
                                                  )
                                                ],
                                              ))
                                        ],
                                      )
                                    ],
                                  )))),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(children: <Widget>[
                      SizedBox(width: 5.0),
                      Text("Todays ",
                          style: TextStyle(
                              color: Colors.blueAccent[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                      Text("Deals",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0))
                    ]),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('View all')),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                //height: 520.0,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: todaysdealproduct.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          var route = new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new ProductPage());
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
                                        MediaQuery.of(context).size.width * .4,
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: new Image.network(
                                          todaysdealproduct[index]
                                              ["image_path"],
                                        )),
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
                                              todaysdealproduct[index]["name"],
                                              style: TextStyle(
                                                  color: Colors.blueAccent[700],
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15.0),
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
                                              todaysdealproduct[index][
                                                              "sort_description"]
                                                          .length >
                                                      3
                                                  ? todaysdealproduct[index][
                                                              "sort_description"]
                                                          .substring(0, 50) +
                                                      '...'
                                                  : todaysdealproduct[index]
                                                      ["sort_description"],
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
                                          margin:
                                              EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: Row(
                                            children: [
                                              Text(
                                                '\u{20B9}' +
                                                    todaysdealproduct[index]
                                                        ["sell_price"],
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14.0),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '\u{20B9}' +
                                                    todaysdealproduct[index]
                                                        ["base_price"],
                                                style: TextStyle(
                                                    decoration: TextDecoration
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
                                              '20% off',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w700,
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
                      );
                    }),
              )
            ],
          ),
        ),
        bottomNavigationBar: NavBar());
  }

  Future<List<dynamic>> getbannersimage() async {
    var jsonResponse;
    var result = await http.get(Uri.parse(Config.site_url + "getbanners"));
    jsonResponse = json.decode(result.body);
    //print(jsonResponse);
    if (result.statusCode == 200) {
      if (jsonResponse['success'] == true) {
        setState(() {
          bannerImage = jsonResponse['data'];
          bannerLoading = false;
        });
        //print(bannerImage);
        //return jsonResponse['data'];
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

  Future<List<dynamic>> getcategory() async {
    var jsonResponse;
    var result = await http.get(Uri.parse(Config.site_url + "getcategories"));
    jsonResponse = json.decode(result.body);
    //print(jsonResponse);
    if (result.statusCode == 200) {
      if (jsonResponse['success'] == true) {
        setState(() {
          productCategories = jsonResponse['data'];
          categoriesLoading = false;
        });
        //print(productCategories);
        //return jsonResponse['data'];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonResponse["message"]),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(jsonResponse["message"]),
      ));
    }
  }

  Future<List<dynamic>> getfeaturedproduct() async {
    var jsonResponse;
    var result =
        await http.get(Uri.parse(Config.site_url + "getfeaturedproduct"));
    jsonResponse = json.decode(result.body);
    //print(jsonResponse);
    if (result.statusCode == 200) {
      if (jsonResponse['success'] == true) {
        setState(() {
          featuredproduct = jsonResponse['data'];
          featuredproductLoading = false;
        });
        //print(featuredproduct);
        //return jsonResponse['data'];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonResponse["message"]),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(jsonResponse["message"]),
      ));
    }
  }

  Future<List<dynamic>> gettodaysdealproduct() async {
    var jsonResponse;
    var result =
        await http.get(Uri.parse(Config.site_url + "gettodaysdealproduct"));
    jsonResponse = json.decode(result.body);
    //print(jsonResponse);
    if (result.statusCode == 200) {
      if (jsonResponse['success'] == true) {
        setState(() {
          todaysdealproduct = jsonResponse['data'];
          todaysdealLoading = false;
        });
        print(todaysdealproduct);
        //return jsonResponse['data'];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonResponse["message"]),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(jsonResponse["message"]),
      ));
    }
  }
}
