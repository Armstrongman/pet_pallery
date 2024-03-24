import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Pages/User%20Pages/edit_user_page.dart';

class CurrentUserPage extends StatefulWidget {
  const CurrentUserPage({super.key});

  @override
  State<CurrentUserPage> createState() => _CurrentUserPageState();
}

class _CurrentUserPageState extends State<CurrentUserPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  String username = "";

  // When the page is first initialized, call the get username method
  @override
  void initState() {
    super.initState();
    getUsername();
  }

    // Simple method that lets the user sign out
  void signOut(){
    FirebaseAuth.instance.signOut();
  }

  void getUsername() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('Users')
      .doc(currentUser.email)
      .get();

      if (snapshot.exists) {
        // Extract data from the document
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        setState(() {
          username = data['username'];
        });
      } else {
        username= 'User document not found';
      }
  }

  @override
  // Temporary simple widget to show the current users profile page
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: signOut,
              icon: Icon(Icons.logout),
            ),
            Image.asset(
              'Assets/Images/logo-placeholder.png',
              width: 140,
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Going to the page by passing in the documentId into the ApplicantsPage's constructor
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditUserPage(documentId: currentUser.uid)),
                );
              },
            ),
          ],
        ),  
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                SizedBox(height: 10),
                // Profile picture and edit button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage:
                            AssetImage('Assets/Images/user-placeholder.png'),
                      ),
                  ],
                ),
                SizedBox(height: 10),
                // // Username
                Text(
                  username,
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
            ),
          ),
        ),
      ),
    );
  }
}