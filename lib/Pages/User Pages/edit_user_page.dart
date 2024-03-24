import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Components/button.dart';
import 'package:pet_pallery/Components/text_field.dart';

class EditUserPage extends StatefulWidget {
  final String documentId;
  const EditUserPage({super.key, required this.documentId});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
    final currentUser = FirebaseAuth.instance.currentUser!;
  final usernameController = TextEditingController();
  final locationController = TextEditingController();

  // When the page is first initialized, call the load Adoption method
  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  // Method for when the page first loads up to show data
  void loadUserInfo() async{
    // Getting the instance of the AdoptionProfile by using the passed in documentId
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('Users')
      .doc(currentUser.email)
      .get();

      // Extract data from the document
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Setting the state of the text inside of all of the text controller equal to the data that is already in firebase
      setState(() {
        usernameController.text = data['username'];
        locationController.text = data['City State'];
      });
  }

    // Method to update instance in firebase
    Future<void> updateUserInfo() async {
      // If any of the fields are empty...
      if (usernameController.text.isEmpty ||
      locationController.text.isEmpty) {
        // Show error message if any field is empty and return from method so that an update cannot happen
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
        ), 
        );
      return;
      }

      // Retrieve the current user's document from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection("Users").doc(currentUser.email).get();
      // Extract the current username from the user's document
      String currentUsername = userSnapshot.get('username');
      if (usernameController.text != currentUsername)
      {
        // Check if the entered username is already taken
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("Users")
            .where("username", isEqualTo: usernameController.text)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // Username already exists, show error message and return
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Username already exists. Please choose another username.'),
            ),
          );
          return;
        }
      }

      // Username is unique, proceed with updating user info
      await FirebaseFirestore.instance.collection("Users").doc(currentUser.email).update({
        'username': usernameController.text,
        'City State': locationController.text,
      });
    // Return to the previous screen (My Adoptions Page)
    Navigator.pop(context);
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
          'Assets/Images/logo-placeholder.png',
          width: 140,
        ),
        )
        ] 
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            // Adding padding on all of the edges of our widgets
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              // Center everything on the center of the page
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Updating Profile Information"),
                const SizedBox(height:25),
                // Every input widget uses the custom TextField component we made
                MyTextField(controller: usernameController, hintText: 'Type in a unique Username', obscureText: false),
                const SizedBox(height:15),
                // City & State Input
                MyTextField(controller: locationController, hintText: 'Where do you live', obscureText: false),
                const SizedBox(height:15),
                // Update Button calling the method to update the adoption profile in firebase 
                MyButton(onTap: updateUserInfo, text: 'Update Profile Info'),
                const SizedBox(height:5),
              ],
            ),
          ),
        )
      )
    );
  }
}