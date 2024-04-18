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
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  // Temporary simple widget to show the home page
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
          stream: FirebaseFirestore.instance.collection('Posts')
          .where('UserId', isNotEqualTo: currentUser.email)
          //.orderBy('DatePosted')
          .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final posts = snapshot.data!.docs;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return FutureBuilder(
                    future: Future.wait([
                      FirebaseFirestore.instance.collection('PetProfiles').doc(post['PetId']).get(),
                      FirebaseFirestore.instance.collection('Users').doc(post['UserId']).get(),
                    ]),
                    builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final petData = snapshot.data![0];
                        final userData = snapshot.data![1];
                        return PostItem(
                          petName: petData['PetName'],
                          username: userData['username'],
                          description: post['Description'],
                          imageUrl: post['ImageUrl'],
                          datePosted: post['DatePosted'].toDate(),
                        );
                      }
                    },
                  );
                },
              );
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