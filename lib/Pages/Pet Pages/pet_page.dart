import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Components/post.dart';

class PetPage extends StatefulWidget {
  // Passing in the id in order to ensure we only show this pet's post on this page
  final String documentId;
  const PetPage({super.key, required this.documentId});

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  String petName = '';

  @override
  void initState() {
    super.initState();
    fetchPetData();
  }

  // Fetching the data of the pet to show information of it on the page
  void fetchPetData() async {
    // Attempting to fetch the data. If it couldn't, catch it
    try {
      DocumentSnapshot petSnapshot = await FirebaseFirestore.instance
          .collection('PetProfiles')
          .doc(widget.documentId)
          .get();

      // Just getting the name for the time being
      if (petSnapshot.exists) {
        setState(() {
          petName = petSnapshot['PetName'];
        });
      } else {
        print('Pet not found');
      }
    } catch (e) {
      print('Error fetching pet data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar at the top of the screen
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
        // Building a stream builder to show all of the posts associated with this pet based on the passed in id
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Posts')
          .where('PetId', isEqualTo: widget.documentId)
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