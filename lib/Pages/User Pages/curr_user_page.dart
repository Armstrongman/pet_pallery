import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentUserPage extends StatefulWidget {
  const CurrentUserPage({super.key});

  @override
  State<CurrentUserPage> createState() => _CurrentUserPageState();
}

class _CurrentUserPageState extends State<CurrentUserPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
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
                Text("Current User Email: " + currentUser.email!)
              ],
            ),
          ),
        ),
      ),
    );
  }
}