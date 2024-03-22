//import 'dart:html';

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
  late Future<DocumentSnapshot> _userFuture;

  
@override
  void initState() {
    super.initState();
    _userFuture = FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.documentId)
        .get();
  }

  @override
  // Temporary simple widget to show the current users profile page
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Image.asset(
          'Assets/Images/logo-placeholder.png',
          width: 140,
        ),
        )
        ] 
      ),
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: _userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data == null || !snapshot.data!.exists) {
              return Center(child: Text('User not found'));
            }

            // Retrieve user data from snapshot
            var userData = snapshot.data!.data() as Map<String, dynamic>;
            var userName = userData['username'] ?? 'Unknown User';

            return Column(
              children: [
                // Profile picture
                SizedBox(height: 20),
                CircleAvatar( // Display user's profile picture
                  radius: 35,
                  backgroundImage: AssetImage('Assets/Images/user-placeholder.png'),
                ),
                SizedBox(height: 10),
                // Username
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Horizontal line
                Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.grey,
                ),
                // Other content of the user page
              ],
            );
          },
        ),
      ),
      // body: SafeArea(
      //   child: Center(
      //     child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       SizedBox(height: 20), // Add some space between app bar and profile picture
      //       CircleAvatar( // Display user's profile picture
      //         radius: 40,
      //         backgroundImage: AssetImage('Assets/Images/user-placeholder.png'),
      //       ),
      //       SizedBox(height: 10),
      //       Container( // Display a visible line below the profile picture
      //         width: double.infinity,
      //         height: 2,
      //         color: Colors.grey,
      //       ),
      //       // Add other widgets to display user's profile information below the line
      //     ],
      //   ),
      //   )
      // ),
    );
  }
}