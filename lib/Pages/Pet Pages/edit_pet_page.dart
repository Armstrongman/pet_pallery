import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Components/button.dart';
import 'package:pet_pallery/Components/text_field.dart';

class EditPetPage extends StatefulWidget {
  final String documentId;
  const EditPetPage({super.key, required this.documentId});

  @override
  State<EditPetPage> createState() => _EditPetPageState();
}

class _EditPetPageState extends State<EditPetPage> {
  // Dropdown menu text
  String? _selectedAnimal;
  // Text field controllers to grab the text in those field for submission to help push to firebase
  final petNameController = TextEditingController();

  // When the page is first initialized, call the load Pet method
  @override
  void initState() {
    super.initState();
    loadPet();
  }

  // Method for when the page first loads up to show data
  void loadPet() async{
    // Getting the instance of the PetProfile by using the passed in documentId
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('PetProfiles')
      .doc(widget.documentId)
      .get();

      // Extract data from the document
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Setting the state of the text inside of all of the text controller equal to the data that is already in firebase
      setState(() {
        petNameController.text = data['PetName'];
        _selectedAnimal = data['TypeOfPet'];
      });
  }

  // Method to update instance in firebase
    void updatePet(){
      // If any of the fields are empty...
      if (petNameController.text.isEmpty || _selectedAnimal!.isEmpty) {
        // Show error message if any field is empty and return from method so that an update cannot happen
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
        ), 
        );
      return;
      }
      // Now updating the instance of the Pet profile in the 'PetProfiles' collection in Firebase with the passed
      // in id of the pet profile
      FirebaseFirestore.instance.collection("PetProfiles")
      .doc(widget.documentId)
      .update({
        'PetName': petNameController.text,
        'TypeOfPet': _selectedAnimal
    });
    // Return to the previous screen (Current User Page)
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
                const Text("Updating this pet's information!"),
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
                // Update Pet button calling method to add data to firebase
                MyButton(onTap: updatePet, text: 'Update Pet'),
                const SizedBox(height:5),
              ],
            ),
          ),
        )
      )
    );
  }
}