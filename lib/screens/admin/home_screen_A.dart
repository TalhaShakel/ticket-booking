import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:tick/screens/admin/home_A.dart';
import '../../constants.dart';
import 'profile.dart';
import 'acitvityPage.dart';

class MyHomePageA extends StatefulWidget {
  MyHomePageA({Key? key}) : super(key: key);

  @override
  _MyHomePageAState createState() => _MyHomePageAState();
}

class _MyHomePageAState extends State<MyHomePageA> {
  int _currentIndex = 0;
  List<Widget> homeScreens = [
    HomeA(),
    const AcitvityPage(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: homeScreens[_currentIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: kPraimaryColor,
        color: Colors.white,
        height: 60,
        elevation: 2,
        cornerRadius: 0,
        top: 0,
        style: TabStyle.flip,
        initialActiveIndex: _currentIndex,
        onTap: (value) {
          _currentIndex = value;
          setState(() {});
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
        ],
      ),
    );
  }
}
