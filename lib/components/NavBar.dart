import 'package:fishRajkumar/pages/DashboardPage.dart';
import 'package:flutter/material.dart';
import 'package:fishRajkumar/pages/OrderListPage.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

int _selectedIndex = 0;

class _NavBarState extends State<NavBar> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DashboardPage()));
      } else if (_selectedIndex == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OrderListPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view_rounded),
          label: 'All Products',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.open_in_browser_rounded),
          label: 'My Order',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pending_sharp),
          label: 'More',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blueAccent[700],
      onTap: _onItemTapped,
    ));
  }
}
