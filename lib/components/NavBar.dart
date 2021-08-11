import 'package:fishRajkumar/pages/DashboardPage.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DashboardPage()));
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
          label: 'All Category',
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
