import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

final List<String> imgList = [
  'https://i.ytimg.com/vi/bTppD-KJRzk/maxresdefault.jpg',
  'https://5.imimg.com/data5/UJ/RM/MY-5875213/indian-mackeral-fish-500x500.jpg'
];
enum BestTutorSite { gram, kg }

class ProductDetailPage extends StatefulWidget {
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  BestTutorSite _site = BestTutorSite.gram;
  String _quantityType = "gm";
  final TextEditingController _quantity = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * .30,
                child: Carousel(
                  autoplay: false,
                  showIndicator: true,
                  dotIncreasedColor: Colors.blueAccent,
                  dotSize: 5.0,
                  dotPosition: DotPosition.bottomCenter,
                  images: imgList
                      .map(
                        (item) => Container(
                          child: Center(
                              child: Image.network(item, fit: BoxFit.cover)),
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
                    "Gong Tengra",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38),
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
                            '\u{20B9}' + "120",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '\u{20B9}' + "180",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 15,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "2o% off",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.0),
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
                      child: Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextField(
                        controller: _quantity,
                        cursorColor: Colors.blueAccent,
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 15.0),
                        decoration: InputDecoration(
                            hintText: 'Quantity',
                            hintStyle: TextStyle(
                                fontSize: 15.0, color: Colors.blueAccent),
                            border: InputBorder.none,
                            filled: true,
                            //fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(10.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(
                                  color: Colors.blueAccent, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(
                                  color: Colors.blueAccent, width: 2.0),
                            )),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white70,
                          border: Border.all()),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          isDense: true,
                          value: _quantityType,
                          onChanged: (String newValue) {
                            setState(() {
                              _quantityType = newValue;
                            });
                          },
                          items: <String>['gm', 'kg']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   icon: Icon(Icons.shopping_basket),
      //   label: Text(
      //     "Add To Cart",
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      //   backgroundColor: Colors.blueAccent,
      // ),
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
