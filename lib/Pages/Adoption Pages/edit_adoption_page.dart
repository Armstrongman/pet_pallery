import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Components/button.dart';
import 'package:pet_pallery/Components/text_field.dart';

class EditAdoptionPage extends StatefulWidget {
  // Passing in the id of the AdoptionProfile we are wanting to update
  final String documentId;
  const EditAdoptionPage({super.key, required this.documentId});

  @override
  State<EditAdoptionPage> createState() => _EditAdoptionPageState();
}

class _EditAdoptionPageState extends State<EditAdoptionPage> {
  // Dropdown menu text
  String? _selectedAnimal;
  // Text field controllers to grab the text in those field for submission to help push to firebase
  final petNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  // When the page is first initialized, call the load Adoption method
  @override
  void initState() {
    super.initState();
    loadAdoption();
  }

  // Method for when the page first loads up to show data
  void loadAdoption() async{
    // Getting the instance of the AdoptionProfile by using the passed in documentId
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('AdoptionProfiles')
      .doc(widget.documentId)
      .get();

      // Extract data from the document
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Setting the state of the text inside of all of the text controller equal to the data that is already in firebase
      setState(() {
        petNameController.text = data['PetName'];
        locationController.text = data['Location'];
        descriptionController.text = data['Description'];
        _selectedAnimal = data['TypeOfPet'];
      });

  }

    // Method to update instance in firebase
    void updateAdoption(){
      // If any of the fields are empty...
      if (petNameController.text.isEmpty ||
      locationController.text.isEmpty ||
      descriptionController.text.isEmpty ||
      _selectedAnimal!.isEmpty) {
        // Show error message if any field is empty and return from method so that an update cannot happen
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
        ), 
        );
      return;
      }

      // Now updating the instance of the adoption profile in the 'AdoptionProfiles' collection in Firebase with the passed
      // in id of the adoption profile
      FirebaseFirestore.instance.collection("AdoptionProfiles")
      .doc(widget.documentId)
      .update({
        'PetName': petNameController.text,
        'Description': descriptionController.text,
        'Location': locationController.text,
        'TypeOfPet': _selectedAnimal
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
                const Text("Updating Adoption Profile"),
                const SizedBox(height:25),
                // Every input widget uses the custom TextField component we made
                // Pet's Name input
                MyTextField(controller: petNameController, hintText: 'Enter the Pet\'s Name', obscureText: false),
                const SizedBox(height:15),
                // Description input
                MyTextField(controller: descriptionController, hintText: 'Give a Brief Description of your pet', obscureText: false),
                const SizedBox(height:15),
                // City & State Input
                MyTextField(controller: locationController, hintText: 'Enter a City and State of Pet', obscureText: false),
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
                // Update Button calling the method to update the adoption profile in firebase 
                MyButton(onTap: updateAdoption, text: 'Update Adoption Profile'),
                const SizedBox(height:5),
              ],
            ),
          ),
        )
      )
    );
  }
}