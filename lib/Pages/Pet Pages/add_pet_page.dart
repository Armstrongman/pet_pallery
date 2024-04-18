import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Components/button.dart';
import 'package:pet_pallery/Components/text_field.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {

  // Dropdown menu text
  String? _selectedAnimal;
  // Text field controllers to grab the text in those field for submission to help push to firebase
  final currentUser = FirebaseAuth.instance.currentUser!;
  final petNameController = TextEditingController();

  // Method to add the new pet to the firebase database
  void addPet(){
    // Check if all fields are filled before submitting
    if (petNameController.text.isEmpty || _selectedAnimal == null) {
      // Show error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
        ), 
      );
    return;
    }
      // Now creating an instance of the pet profile in the 'PetProfiles' collection in Firebase
      FirebaseFirestore.instance.collection("PetProfiles").add({
        'PetName': petNameController.text,
        'TypeOfPet': _selectedAnimal,
        'UserId': currentUser.email
    });
    // Pop up back to the previous screen (Current User Page) after submitting
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
          'Assets/Images/pet-pallery-logo.png',
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
                const Text("Adding a Pet to your Page"),
                const SizedBox(height:25),
                // Every input widget uses the custom TextField component we made
                // Pet name Input
                MyTextField(controller: petNameController, hintText: 'Enter the Pet\'s Name', obscureText: false),
                const SizedBox(height:15),
                // Dropdown button allowing users to select and animal
                DropdownButton<String>(
                  value: _selectedAnimal,
                  // When an option is selected, show the one that was selected and change the _selectedAnimal value
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedAnimal = newValue!;
                    });
                  },
                  // Dropdown options
                  items: <String>['Dog', 'Cat', 'Bird', 'Fish', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                // Create Pet button calling method to add data to firebase
                MyButton(onTap: addPet, text: 'Create Pet Profile'),
                const SizedBox(height:5),
              ],
            ),
          ),
        )
      )
    );
  }
}