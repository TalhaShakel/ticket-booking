import 'package:flutter/material.dart';
import 'package:tick/constants.dart';

class HomeA extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          shadowColor: kPraimaryColor,
          backgroundColor: kPraimaryColor,
          surfaceTintColor: kPraimaryColor,
          elevation: 0,
          title: const Text('Admin Home'),
        ),
        body: const Center(child: Text("Welcome Admin")));
  }
}
