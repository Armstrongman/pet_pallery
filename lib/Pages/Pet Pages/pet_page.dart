import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PetPage extends StatefulWidget {
  final String documentId;
  const PetPage({super.key, required this.documentId});

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  String petName = '';

  @override
  void initState() {
    super.initState();
    fetchPetData();
  }

  void fetchPetData() async {
    try {
      DocumentSnapshot petSnapshot = await FirebaseFirestore.instance
          .collection('PetProfiles')
          .doc(widget.documentId)
          .get();

      if (petSnapshot.exists) {
        setState(() {
          petName = petSnapshot['PetName'];
        });
      } else {
        print('Pet not found');
      }
    } catch (e) {
      print('Error fetching pet data: $e');
    }
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
      body: (
        Center(
          child: Text(
          petName.isNotEmpty ? petName : 'Loading...', // Show loading text if pet name is empty
          style: TextStyle(fontSize: 24.0),
        ),
        )
      )
    );
  }
}