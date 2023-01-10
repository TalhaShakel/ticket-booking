import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tick/constants.dart';
import 'package:ticket_widget/ticket_widget.dart';

class MyTickets extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MyTickets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kPraimaryColor,
          elevation: 0,
          title: Text('My Tickets'),
        ),
        body: _buildChildren());
  }
}

@immutable
class Ticket {
  Ticket({required this.name});
  Ticket.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
        );

  Map<String, Object?> toJson() {
    return {'name': name};
  }

  final String name;
}

_buildChildren() {
  return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("tickets").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          final tickets = snapshot.data!.docs
              .where((e) =>
                  e.get('user') ==
                  FirebaseAuth.instance.currentUser!.uid.toString())
              .toList();
          return GridView.count(
            primary: false,
            crossAxisCount: 1,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(tickets.length, (index) {
              var ticket = tickets[index];
              return TicketWidget(
                width: 40,
                height: 150,
                isCornerRounded: true,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          'Ticket Information : ',
                          style: TextStyle(
                              color: Colors.orange[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          children: <Widget>[
                            ticketDetailsWidget('Name :', ticket.get('name'),
                                'Description :', ticket.get('desciption')),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 25, right: 20, bottom: 42),
                              child: ticketDetailsWidget(
                                  'Premuim:',
                                  ticket.get('countPremuim').toString(),
                                  'Standard :',
                                  ticket.get('countStandard').toString()),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 300,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    width: 1.5, color: kScondaryColor)),
                            child: Center(
                              child: Text(
                                'Premium Ticket',
                                style: TextStyle(
                                    color: Colors.orange[900],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150,
                          height: 80,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('barcode.png'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '9824 0972 1742 1298',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        }
      });
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                firstDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              secondTitle,
              style: TextStyle(
                  color: Colors.blueAccent[100], fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                secondDesc,
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      )
    ],
  );
}
