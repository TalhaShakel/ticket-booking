import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:tick/screens/add_new_ticket.dart';
import 'package:tick/screens/profile.dart';
import 'package:tick/screens/tickets_screen.dart';

import '../constants.dart';
import 'get_teckite.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> homeScreens = [
    TicketScreen(),
    MyTickets(),
    AddTicketPage(),
    Profile(),
    TicketScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: homeScreens.elementAt(_currentIndex)),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: kPraimaryColor,
        height: 60,
        elevation: 2,
        cornerRadius: 0,
        color: Colors.white,
        style: TabStyle.flip,
        initialActiveIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          TabItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: "Home",
          ),
          TabItem(
            icon: Icon(
              Icons.store_mall_directory,
              color: Colors.white,
            ),
            title: "My Ticket",
          ),
          TabItem(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            title: "Add",
          ),
          TabItem(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: "My Profile",
          ),
          TabItem(icon: Icon(color: Colors.white, Icons.shopping_cart))
        ],
      ),
    );
  }
}
