import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Pages/User%20Pages/user_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // String for when the user begins to search
  String _searchQuery = '';
  // Initialize search text box controller
  TextEditingController _searchController = TextEditingController();
  
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Users',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              // Getting all of the users that either match the pattern of the text in the text box
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .where('username', isGreaterThanOrEqualTo: _searchQuery)
                  .where('username', isLessThan: _searchQuery + 'z')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No users found.'));
                }
                // Now showing those users we got from the stream
                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(userData['username']),
                      // Add onTap functionality to navigate to user's profile
                      onTap: () {
                        // Navigate to the user's page with the corresponding document ID
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserPage(documentId: document.id),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}