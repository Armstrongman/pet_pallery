import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Pages/Adoption%20Pages/add_adoption_page.dart';
import 'package:pet_pallery/Pages/Adoption%20Pages/applicants_page.dart';
import 'package:pet_pallery/Pages/Adoption%20Pages/edit_adoption_page.dart';

class MyAdoptionsPage extends StatefulWidget {
  const MyAdoptionsPage({super.key});

  @override
  State<MyAdoptionsPage> createState() => _MyAdoptionsPageState();
}

class _MyAdoptionsPageState extends State<MyAdoptionsPage> {
  // Getting the current users data
  final currentUser = FirebaseAuth.instance.currentUser!;

  // Method to delete an Adoption, passing in the documentId to specify which one we want to delete
  void deleteAdoption(String documentId)
  {
    // Go into firebase and retrieve the instance associated with the doumentId and then delete it
    FirebaseFirestore.instance
      .collection('AdoptionProfiles')
      .doc(documentId)
      .delete();
  }
  @override
Widget build(BuildContext context) {
  return Scaffold(
    // Appbar at the top of the screen
    appBar: AppBar(
      title: Text('My Adoptions'),
    ),
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                'Your Current Pets Up for Adoption',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Button to go add a new adoption
          ElevatedButton(
            onPressed: () {
              // Navigate to AddAnAdoption page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddAdoptionPage()),
              );
            },
            child: Text('Add Adoption'),
          ),
          SizedBox(height: 16),
          // An expanded widget that lets us see a list view of all the current user's adoption profiles
          Expanded(
            child: StreamBuilder(
              // Only grabbing the AdoptionProfiles where the instance's UserId is equal to the current user's id
              stream: FirebaseFirestore.instance
                  .collection('AdoptionProfiles')
                  .where('UserId', isEqualTo: currentUser.uid)
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
                  return Center(child: Text('No adoption profiles found.'));
                }
                // Building out a list view with the data in the snapshot
                return Container(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    // The children is each instance that was queried, mapping each instance to the variable data
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Showing the PetName data
                            Text(
                              'Pet Name: ${data['PetName']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            // Showing the TypeOfPet data
                            Text(
                              'Type: ${data['TypeOfPet']}',
                            ),
                            SizedBox(height: 8.0),
                            // Showing the Location data
                            Text(
                              'Location: ${data['Location']}',
                            ),
                            SizedBox(height: 8.0),
                            // Showing the description data
                            Text(
                              'Description: ${data['Description']}',
                            ),
                            SizedBox(height: 8.0),
                            // Row for the three buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Button on each instance of the list view allowing the user to edit that adoption profile
                                ElevatedButton(
                                  onPressed: () {
                                    // Going to the page by passing in the documentId into the EditAdoptionPage's constructor
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EditAdoptionPage(documentId: document.id)),
                                    );
                                  },
                                  child: Text('Edit'),
                                ),
                                SizedBox(width: 8.0),
                                // Button on each instance of the list view allowing the user to view the people who have applied to adopt
                                // that specific pet
                                ElevatedButton(
                                  onPressed: () {
                                    // Going to the page by passing in the documentId into the ApplicantsPage's constructor
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ApplicantsPage(documentId: document.id)),
                                    );
                                  },
                                  child: Text('View Applicants'),
                                ),
                                SizedBox(width: 8.0),
                                // Button on each instance of the list view allowing the user to delete that specific Adoption Profile
                                ElevatedButton(
                                  // Calling the method to delete the instance in Firebase
                                  onPressed: () {
                                    deleteAdoption(document.id);
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

}