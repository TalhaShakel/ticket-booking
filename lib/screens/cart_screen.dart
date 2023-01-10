import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tick/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TicketScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<TicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kPraimaryColor,
          elevation: 0,
          title: Text('Tickets'),
        ),
        body: _buildChildren());
  }
}

_buildChildren() {
  return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("cart").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          return GridView.count(
            primary: false,
            crossAxisCount: 1,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(snapshot.data!.docs.length, (index) {
              var ticket = snapshot.data!.docs[index];
              return Text(ticket.get('name'));
            }),
          );
        }
      });
}
