import 'package:flutter/material.dart';
import 'package:tick/constants.dart';

class AcitvityPage extends StatefulWidget {
  const AcitvityPage({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AcitvityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kPraimaryColor,
          elevation: 0,
          title: const Text('Activity Page'),
        ),
        body: const Center(child: Text("Activity")));
  }
}
