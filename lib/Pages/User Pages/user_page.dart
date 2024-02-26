import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  final String documentId;
  const UserPage({super.key, required this.documentId});

  @override
  State<UserPage> createState() => _UserPageState();
}



class _UserPageState extends State<UserPage> {
  //final user = FirebaseFirestore.instance.collection('Users').where('UserId', isEqualTo: widget.);
  @override
  // Temporary simple widget to show the current users profile page
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              // Align every widget on the center of the screen
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Text("This User's Email: " + user.email!)
              ],
            ),
          ),
        ),
      ),
    );
  }
}