import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Pages/Pet%20Pages/add_pet_page.dart';
import 'package:pet_pallery/Pages/Pet%20Pages/edit_pet_page.dart';
import 'package:pet_pallery/Pages/Pet%20Pages/pet_page.dart';
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

   // Method to delete an Adoption, passing in the documentId to specify which one we want to delete
  void deletePet(String documentId)
  {
    // Go into firebase and retrieve the instance associated with the doumentId and then delete it
    FirebaseFirestore.instance
      .collection('PetProfiles')
      .doc(documentId)
      .delete();
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
                SizedBox(height: 16),
                // An expanded widget that lets us see a list view of all the current user's adoption profiles
                Expanded(
                  child: StreamBuilder(
                    // Only grabbing the AdoptionProfiles where the instance's UserId is equal to the current user's id
                    stream: FirebaseFirestore.instance
                        .collection('PetProfiles')
                        .where('UserId', isEqualTo: currentUser.email)
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
                                    // Popup menu button for edit and delete options
                                    PopupMenuButton(
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 'edit',
                                          child: Text('Edit'),
                                        ),
                                        PopupMenuItem(
                                          value: 'delete',
                                          child: Text('Delete'),
                                        ),
                                      ],
                                      onSelected: (String value) {
                                        if (value == 'edit') {
                                          // Going to the page by passing in the documentId into the ApplicantsPage's constructor
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => EditPetPage(documentId: document.id)),
                                          );
                                        } else if (value == 'delete') {
                                          deletePet(document.id);
                                        }
                                      },
                                    ),
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
                            // return Card(
                            //   elevation: 4.0, // Add elevation for a shadow effect
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(8.0),
                            //   ),
                            //   margin: EdgeInsets.symmetric(vertical: 8.0),
                            //   child: Padding(
                            //     padding: EdgeInsets.all(16.0),
                            //     child: Column(
                            //       children: [
                            //         // Popup menu button for edit and delete options
                            //         PopupMenuButton(
                            //           itemBuilder: (context) => [
                            //             PopupMenuItem(
                            //               value: 'edit',
                            //               child: Text('Edit'),
                            //             ),
                            //             PopupMenuItem(
                            //               value: 'delete',
                            //               child: Text('Delete'),
                            //             ),
                            //           ],
                            //           onSelected: (String value) {
                            //             if (value == 'edit') {
                            //               // Going to the page by passing in the documentId into the ApplicantsPage's constructor
                            //               Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(builder: (context) => EditPetPage(documentId: document.id)),
                            //               );
                            //             } else if (value == 'delete') {
                            //               deletePet(document.id);
                            //             }
                            //           },
                            //         ),
                            //         // Show the PetName in the middle of the card
                            //         Text(
                            //           data['PetName'],
                            //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                            //           textAlign: TextAlign.center,
                            //         ),
                            //         SizedBox(height: 8.0),
                            //         // Add other details or buttons as needed
                            //       ],
                            //     ),
                            //   ),
                            // );
                          }).toList(),
                        ),
                      );

                    },
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    // Handle the action for adding a pet to the profile
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddPetPage()),
                    );
                  },
                  child: Icon(Icons.add),
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}