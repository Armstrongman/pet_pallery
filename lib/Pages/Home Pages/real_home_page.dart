// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Components/post.dart';

class RealHomePage extends StatefulWidget {
  const RealHomePage({super.key});

  @override
  State<RealHomePage> createState() => _RealHomePageState();
}

class _RealHomePageState extends State<RealHomePage> {
  // Getting infromation from the current user

  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Image.asset(
          'Assets/Images/pet-pallery-logo.png',
          width: 140,
        ),
        )
        ] 
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          // Building a stream with posts collection where the userId of the post is not equal to the current user's id
          stream: FirebaseFirestore.instance.collection('Posts')
          .where('UserId', isNotEqualTo: currentUser.email)
          .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final posts = snapshot.data!.docs;
              // Showing all of the post in a listview of PostItems
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return FutureBuilder(
                    future: Future.wait([
                      // Getting information from the pet as well as the user associated with this post by using their ids
                      FirebaseFirestore.instance.collection('PetProfiles').doc(post['PetId']).get(),
                      FirebaseFirestore.instance.collection('Users').doc(post['UserId']).get(),
                    ]),
                    builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // Setting petData and userData equal to their respective instances of a pet and user in the database
                        final petData = snapshot.data![0];
                        final userData = snapshot.data![1];
                        // Making a PostItem of this current post instance from inside of the database
                        return PostItem(
                          petName: petData['PetName'],
                          userId: userData.id,
                          username: userData['username'],
                          postId: post.id,
                          description: post['Description'],
                          imageUrl: post['ImageUrl'],
                          datePosted: post['DatePosted'].toDate(),
                        );
                      }
                    },
                  );
                },
              );
              // If an eror occured while trying to load in the page, tell the user
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}