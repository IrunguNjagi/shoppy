import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shoppy/screens/cart_page.dart';
import 'package:shoppy/screens/home_page.dart';
import 'package:shoppy/screens/product_view.dart';
import 'package:shoppy/screens/profle_page.dart';
import 'package:shoppy/screens/saved.dart';
import 'package:shoppy/widgets/search_tab.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({Key? key}) : super(key: key);

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {

  int _selectedIndex = 0;
  List<Widget> _pages = <Widget>[
    HomePage(),
    SaveTab(),
    SearchTab(),
    LogoutPage(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: GNav(
        //gap: 3.0,
        color: Colors.grey,
        activeColor: Colors.pinkAccent,
        backgroundColor: Colors.white,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
          ),
          GButton(
            icon: Icons.favorite,
            text: 'Wishlist',
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
          GButton(
            icon: Icons.search_sharp,
            text: 'Search',
            onPressed: () {
              setState(() {
                _selectedIndex = 2;
              });
            },
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
            onPressed: () {
              setState(() {
                _selectedIndex = 3;
              });
            },
          ),
        ],
      ),
    );
  }
}

