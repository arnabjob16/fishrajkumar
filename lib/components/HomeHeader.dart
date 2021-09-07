import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(130);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
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
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.34,
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
    );
  }
}
