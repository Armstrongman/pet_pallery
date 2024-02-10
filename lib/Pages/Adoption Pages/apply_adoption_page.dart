import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Components/button.dart';
import 'package:pet_pallery/Components/text_field.dart';

class ApplyForAdoption extends StatefulWidget {
  // Passing in the documentId of the Adoption Profile
  final String documentId;
  const ApplyForAdoption({super.key, required this.documentId});

  @override
  State<ApplyForAdoption> createState() => _ApplyForAdoptionState();
}

class _ApplyForAdoptionState extends State<ApplyForAdoption> {
  // Getting the current user who is submitting an application to grab their id
  final currentUser = FirebaseAuth.instance.currentUser!;
  // Text field controllers to grab the text in those field for submission to help push to firebase
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final reasonController = TextEditingController();
  String? selectedAnimal;

  // Method linked to button to successfully submit an application
  applyToAdopt()
  {
    // Checking to see if any of the fields are empty
    if (nameController.text.isEmpty ||
      phoneController.text.isEmpty ||
      reasonController.text.isEmpty) {
      // If there are any show a message and then return out of the method
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
        ), 
      );
    return;
  }

      // Now creating an instance of the submitted application in the 'Applicants' collection in Firebase
      FirebaseFirestore.instance.collection("Applicants").add({
        'Name': nameController.text,
        'PhoneNumber': phoneController.text,
        'Reason': reasonController.text,
        'AdoptionId': widget.documentId,
        'UserId': currentUser.uid

    });
    // Go back to the adoption home page
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      // Appbar at the top of the page
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
                const Text("Apply to Adopt a Pet"),
                const SizedBox(height:25),
                // Every input widget uses the custom TextField component we made
                // name Input
                MyTextField(controller: nameController, hintText: 'Enter your name', obscureText: false),
                const SizedBox(height:15),
                // Phone Number input
                MyTextField(controller: phoneController, hintText: 'Your Phone Number', obscureText: false),
                const SizedBox(height:15),
                // Reason Input
                MyTextField(controller: reasonController, hintText: 'Reason you want to adopt', obscureText: false),
                const SizedBox(height:15),
                // Submit Application Button
                MyButton(onTap: applyToAdopt, text: 'Submit Application'),
                const SizedBox(height:5),
              ],
            ),
          ),
        )
      )
    );
  }
}