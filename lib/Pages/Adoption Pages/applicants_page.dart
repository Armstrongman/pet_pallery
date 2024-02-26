// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ApplicantsPage extends StatefulWidget {
  // String that will be passed into the constructor informing the widget what the id of the Adoption Profile is
  final String documentId;
  const ApplicantsPage({super.key, required this.documentId});

  @override
  State<ApplicantsPage> createState() => _ApplicantsPageState();
}

class _ApplicantsPageState extends State<ApplicantsPage> {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            // An expanded widget that lets us see a list view of all the adoption profile's applicants
            Expanded(
              child: StreamBuilder(
                // Only grabbing the AdoptionProfiles where the instance's UserId is equal to the current adoption profile's id
                stream: FirebaseFirestore.instance
                    .collection('Applicants')
                    .where('AdoptionId', isEqualTo: widget.documentId)
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
                  // The adoption profile currently does not have any applicants yet
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('There are no applicants at this time'));
                  }
                  // If not empty and successful build out a list view with the data in the snapshot
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
                          child: Row(children: [
                            Column(
                              children: const [
                                Image(
                                  image: AssetImage('Assets/Images/user-placeholder.png'),
                                  width: 50,
                                ),
                              ],
                            ),
                            SizedBox(width: 15.0,),
                            Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Showing the Name data
                              Text(
                                '${data['Name']}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.0),
                              // Showing the PhoneNumber data
                              Text(
                                'Phone #: ${data['PhoneNumber']}',
                              ),
                              SizedBox(height: 8.0),
                              // Showing the Reason data
                              Text(
                                'Reason: ${data['Reason']}',
                              ),
                            ],
                          ),
                          ],)
                          // child: Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     // Showing the Name data
                          //     Text(
                          //       '${data['Name']}',
                          //       style: TextStyle(fontWeight: FontWeight.bold),
                          //     ),
                          //     SizedBox(height: 8.0),
                          //     // Showing the PhoneNumber data
                          //     Text(
                          //       'Phone #: ${data['PhoneNumber']}',
                          //     ),
                          //     SizedBox(height: 8.0),
                          //     // Showing the Reason data
                          //     Text(
                          //       'Reason: ${data['Reason']}',
                          //     ),
                          //   ],
                          // ),
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