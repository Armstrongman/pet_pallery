import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Pages/User%20Pages/user_page.dart';

class CommentPage extends StatefulWidget {
  final String documentId;
  const CommentPage({super.key, required this.documentId});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  // Initialize text controller for text box
  final commentController = TextEditingController();
  // Get the current user to eventually get their id
  final currentUser = FirebaseAuth.instance.currentUser!;

  // Method to submit the comment to the application
  void SubmitComment(){
    // Uploading the comment to the "Comments" collection inside of the databse
    FirebaseFirestore.instance.collection("Comments").add({
        'CommentText': commentController.text,
        'PostId': widget.documentId,
        'UserId': currentUser.email,
        'Timestamp': DateTime.now()
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
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
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16),
          Expanded(            
            child: StreamBuilder(
              // Retrieving all of the comments in the database that are associated with this post using its id
              stream: FirebaseFirestore.instance
                  .collection('Comments')
                  .where('PostId', isEqualTo: widget.documentId)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                // Loading comments
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                // Error occured
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                // If no comments were found, message telling the user that no one has commented yet will appear
                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('Nobody has Commented on this Post Yet'));
                }
                return Container(
                  padding: EdgeInsets.all(1.0),
                  // Showing each comment associated with the post in a listview
                  child: ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserPage(documentId: '${data['UserId']}'),
                                      ),
                                    );
                                  },
                                  child: Image(
                                    image: AssetImage('Assets/Images/user-placeholder.png'),
                                    width: 50,
                                  ),
                                ),
                                // Temporarily showing the email of the user besides the username of the user
                                Text(
                                  '${data['UserId']}',
                                  style: TextStyle(fontSize: 10),
                                ),
                                SizedBox(height: 8.0),
                              ],
                            ),
                            SizedBox(width: 15.0,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Showing the comment this specific user left
                                Text(
                                  '${data['CommentText']}',
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
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: 'Enter your comment...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 8),
              // Button to submit comment
              IconButton(
                onPressed: () {
                  // Call a method to handle submitting the comment
                  SubmitComment();
                },
                icon: Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

}