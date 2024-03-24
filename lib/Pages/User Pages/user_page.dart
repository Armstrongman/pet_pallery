//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Pages/Pet%20Pages/pet_page.dart';

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
            var userId = snapshot.data!.id;
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
                SizedBox(height: 16),
                // An expanded widget that lets us see a list view of all the current user's adoption profiles
                Expanded(
                  child: StreamBuilder(
                    // Only grabbing the AdoptionProfiles where the instance's UserId is equal to the current user's id
                    stream: FirebaseFirestore.instance
                        .collection('PetProfiles')
                        .where('UserId', isEqualTo: userId)
                        .snapshots(),
                    // Taking the data from the stream above
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      // An error occured when attempting to grab the data
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      // The user currently does not have an adoption profile they have made yet
                      if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('You currently have no pets on your page'));
                      }
                      // Building out a list view with the data in the snapshot
                      return Container(
                        padding: EdgeInsets.all(16.0),
                        child: ListView(
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: () {
                                // Going to the page by passing in the documentId into the ApplicantsPage's constructor
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PetPage(documentId: document.id)),
                                );
                              },
                              child: Card(
                                elevation: 4.0, // Add elevation for a shadow effect
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    // Show the PetName in the middle of the card
                                    Text(
                                      data['PetName'],
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 8.0),
                                    // Add other details or buttons as needed
                                  ],
                                ),
                              ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}