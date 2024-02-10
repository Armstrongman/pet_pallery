import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Pages/Adoption%20Pages/apply_adoption_page.dart';
import 'package:pet_pallery/Pages/Adoption%20Pages/my_adoptions_page.dart';

class AdoptionPage extends StatefulWidget {
  const AdoptionPage({super.key});

  @override
  State<AdoptionPage> createState() => _AdoptionPage();
}

class _AdoptionPage extends State<AdoptionPage> {
    // Selects the default option when the page is opened up for the dropdown
   String? selectedAnimal;

  @override
  Widget build(BuildContext context) {
    // Grabing the current user so we can retrieve their id
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Row at top of page containing the dropdown button and the button to go to your adoptions
            Row(children: [
              Container(
                width: 205,
                child: Column(children: [
                  // Dropdown button
                  DropdownButton<String>(
                    value: selectedAnimal,
                    // Any time an option is selected/changed, update the value of selectedAnimal
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedAnimal = newValue!;
                      });
                    },
                    // What is shown before selecting an option
                    hint: Text('Select a type of animal', style: TextStyle(fontSize: 14.0),),
                    icon: Icon(Icons.arrow_drop_down), // Add dropdown icon
                    iconSize: 24, // Set icon size
                    elevation: 16, // Add elevation
                    style: TextStyle(color: Colors.black, fontSize: 16), // Set font style
                    underline: Container( // Set underline color
                      height: 2,
                      color: Colors.blue,
                    ),
                    // Options
                    items: <String>['Dog', 'Cat', 'Bird', 'Fish', 'Other']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                      }).toList(),
                  ),
                ]),
              ),
              // My Adoptions button
              ElevatedButton(
                  onPressed: () {
                    // Navigate to MyAdoptionsPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyAdoptionsPage()),
                    );
                  },
                  child: Text('My Adoptions'),
                ),
            ],
            ),
            // Add some spacing between the button and the list
            SizedBox(height: 16),
            // An expanded widget that lets us see a list view of all of the adoptions currently listed
            Expanded(
              child: StreamBuilder(
                // Searching through the AdoptionProfiles collection and only getting the ones that aren't equal to the
                // current user's id 
                stream: FirebaseFirestore.instance
                    .collection('AdoptionProfiles')
                    .where('UserId', isNotEqualTo: currentUser.uid)
                    //.where('TypeOfPet', isEqualTo: selectedAnimal) /*NEED TO FIX LATER*/
                    .snapshots(),
                // Taking the data from the stream above
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  // While we are waiting for the data to load, show a progress indicator bar
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  // If an error occured, explain the error and show it on screen
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  // If not data was present in the snapshot, tell the user
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No other pets have been put up for adoption.'));
                  }
                  // Else, show the adoption profiles
                  return Container(
                    padding: EdgeInsets.all(16.0),
                    // Presenting the data in a list view
                    child: ListView(
                      // Mapping each instance of the snapshot to a document snapshot so I can present the data
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                        // Showing the data inside of a container
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
                              Text(
                                // Retrieving the Pet Name data of the instance
                                'Pet Name: ${data['PetName']}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                // Retrieving the Type of Pet data of the instance
                                'Type: ${data['TypeOfPet']}',
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                // Retrieving the Location data of the instance
                                'Location: ${data['Location']}',
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                // Retrieving the Description data of the instance
                                'Description: ${data['Description']}',
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 8.0),
                                  // Button allowing people to apply for an adoption of the specific adoption profile
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        // Routing to the page passing the current instance's id to the ApplyForAdoption page
                                        MaterialPageRoute(builder: (context) => ApplyForAdoption(documentId: document.id,)),
                                      );
                                    },
                                    child: Text('Apply For Adoption'),
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