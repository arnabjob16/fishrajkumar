import 'dart:convert';

import 'package:fishRajkumar/components/Config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  final title = 'Home';
  List dashData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.orange,
        ),
        body: Container(
          child: FutureBuilder(
              future: dashboard_category(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> dashData) {
                //print(dashData);
                if (dashData.hasData) {
                  return GridView.count(
                    crossAxisCount: 2,
                    children:
                        List.generate(dashData.data?.length ?? 0, (index) {
                      return GestureDetector(
                        onTap: () => print('aa'),
                        child: Card(
                          elevation: 7, // Change this
                          shadowColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20))),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: 125,
                                height: 125,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            dashData.data[index]['icon']),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 2.0,
                                    bottom: 2.0),
                                width: double.infinity,
                                height: 40.0,
                                child: Text(
                                  dashData.data[index]['name'],
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'OpenSans',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                decoration:
                                    BoxDecoration(color: Colors.blueGrey[100]),
                              )
                            ],
                          )),
                        ),
                      );
                    }),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ));
  }

  Future<List<dynamic>> dashboard_category() async {
    var jsonResponse;
    var result = await http.get(Uri.parse(Config.site_url + "addresslist"));
    jsonResponse = json.decode(result.body);
    if (result.statusCode == 200) {
      if (jsonResponse['result'] == 1) {
        return jsonResponse['data'];
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
}
