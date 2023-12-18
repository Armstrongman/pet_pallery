import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Simple function that allows the user to log out of their account
  void signOut(){
    FirebaseAuth.instance.signOut();
  }


  // Building out our HomePage widget, very simplistic design for first code drop
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page of Pet Pallery"),
        // Icon that is a button that allows user to sign out when pressed on
        actions: [
          IconButton(onPressed: signOut, icon: Icon(Icons.logout)),
        ],  
      ),
    );
  }
}