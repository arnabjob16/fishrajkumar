import 'dart:convert';

import 'package:fishRajkumar/components/Header.dart';
import 'package:fishRajkumar/pages/AddressListPage.dart';
import 'package:flutter/material.dart';
import 'package:fishRajkumar/components/Config.dart';
import 'package:fishRajkumar/components/NavBar.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

double shipping;
var rkey = '';
var appname = '';
var description = '';
var userid = '';
var email = '';
var phone = '';
double subtotal = 0.00;
double alltotal = 0.00;
String defaultaddress = '';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List cartProduct = [];
  bool cartProductLoading = true;
  String defaultaddress = '';
  @override
  void initState() {
    super.initState();
    subtotal = 0.00;
    alltotal = 0.00;
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _incrementCounter();
    getcartproduct();
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shipping = double.parse(prefs.getString('shipping'));
      email = prefs.getString('email');
      phone = prefs.getString('phone');
      userid = prefs.getString('userid');
    });
  }

  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;
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
                    itemCount: cartProduct.length,
                    itemBuilder: (BuildContext context, int index) {
                      return cartProductLoading
                          ? CircularProgressIndicator()
                          : GestureDetector(
                              onTap: () {
                                var route = new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new CheckoutPage());
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
                                          padding:
                                              EdgeInsets.fromLTRB(0, 10, 0, 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              8,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: new Image.network(
                                                cartProduct[index]
                                                    ['image_path'],
                                              )),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .7,
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        cartProduct[index]
                                                            ['product_name'],
                                                        style: TextStyle(
                                                            color: Colors
                                                                    .blueAccent[
                                                                700],
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 15.0),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    color:
                                                        Colors.blueAccent[700],
                                                    padding: EdgeInsets.all(6),
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 5, 0, 0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '\u{20B9}' +
                                                              cartProduct[index]
                                                                  [
                                                                  'total_price'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
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
                                                    cartProduct[index]['weight']
                                                            .toString() +
                                                        ' ' +
                                                        cartProduct[index]
                                                            ['weight_unit'],
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
                            '\u{20B9}' + '${subtotal.toStringAsFixed(2)}',
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
                            '\u{20B9}' + '${shipping.toStringAsFixed(2)}',
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
                            '\u{20B9}' + '${alltotal.toStringAsFixed(2)}',
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
                          onPressed: () {
                            openCheckout();
                          },
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

  Future<List<dynamic>> getcartproduct() async {
    var jsonResponse;
    var PjsonResponse;
    var payment = await http.post(
      Uri.parse(Config.site_url + "paymentsettings"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    PjsonResponse = json.decode(payment.body);

    if (payment.statusCode == 200) {
      if (PjsonResponse['success'] == true) {
        setState(() {
          rkey = PjsonResponse['data']['key'];
          appname = PjsonResponse['data']['name'];
          description = PjsonResponse['data']['description'];
        });
      }
    }
    print(PjsonResponse);

    var result = await http.post(
      Uri.parse(Config.site_url + "getcartdetails"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': '1',
      }),
    );
    jsonResponse = json.decode(result.body);
    print(jsonResponse['data']);
    if (result.statusCode == 200) {
      if (jsonResponse['success'] == true) {
        jsonResponse['data']['cartdata'].forEach((v) => {
              subtotal = subtotal + double.parse(v['total_price']),
            });
        setState(() {
          subtotal = subtotal;
          alltotal = subtotal + shipping;
          cartProduct = jsonResponse['data']['cartdata'];
          defaultaddress = jsonResponse['data']['defaultaddress']['address'] +
              ', ' +
              jsonResponse['data']['defaultaddress']['pincode'] +
              ', ' +
              jsonResponse['data']['defaultaddress']['city'] +
              ', ' +
              jsonResponse['data']['defaultaddress']['state'] +
              ', ' +
              jsonResponse['data']['defaultaddress']['country'];
          cartProductLoading = false;
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

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': rkey,
      'amount': (alltotal * 100).toStringAsFixed(2),
      //'amount': 500,
      'name': appname,
      'description': description,
      'prefill': {'contact': phone, 'email': email},
      'external': {}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("SUCCESS: " + response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("ERROR: " + response.code.toString() + " - " + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("EXTERNAL_WALLET: " + response.walletName);
  }
}
