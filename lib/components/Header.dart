import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(80);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(80.0),
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
              IconButton(
                icon:
                    new Icon(Icons.arrow_back, color: Colors.white, size: 27.0),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.18,
                ),
                Text("Raj ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),
                Text("kumar",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0))
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon:
                        new Icon(Icons.search, color: Colors.white, size: 27.0),
                    onPressed: () {},
                  ),
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
        ]),
        backgroundColor: Colors.blueAccent[200],
      ),
    );
  }
}
