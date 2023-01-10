import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tick/constants.dart';

import 'login_screen.dart';

class Profile extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kPraimaryColor,
          shadowColor: kPraimaryColor,
          elevation: 0,
          title: const Text('My Profile'),
        ),
        body: Center(
          child: TextButton(
            child: const Text('Sign Out'),
            onPressed: () {
              _signOut();
              setState(() {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              });
            },
          ),
        ));
  }
}

Future<LoginScreen> _signOut() async {
  await FirebaseAuth.instance.signOut();
  return const LoginScreen();
}
