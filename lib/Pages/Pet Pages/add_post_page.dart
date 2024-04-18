import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Components/button.dart';
import 'package:pet_pallery/Components/text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Post {
  final String petId;
  final String description;
  final String imageUrl;

  Post({required this.petId, required this.description, required this.imageUrl});

  // Convert a Post object into a Map<String, dynamic> for Firebase
  Map<String, dynamic> toJson() {
    return {
      'petId': petId,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}

class AddPostPage extends StatefulWidget {
  final String documentId;
  const AddPostPage({super.key, required this.documentId});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  Reference referenceDirImages=FirebaseStorage.instance.ref().child('posts');

  File? _imageFile;
  final picker = ImagePicker();
  final descriptionController = TextEditingController();
  String imageUrl = '';

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        //print('${_imageFile?.path}');
      });
    }
  }

  Future<void> uploadPost() async {
    if (_imageFile == null) return; // No image selected

    String uniqueFileName=DateTime.now().millisecondsSinceEpoch.toString();
    // Upload image to Firebase Storage
    Reference ref = referenceDirImages.child(uniqueFileName);
    try{
      // Specify content type as 'image/jpeg'
    final metadata = SettableMetadata(contentType: 'image/jpeg');
      await ref.putFile(File(_imageFile!.path), metadata);
      imageUrl=await ref.getDownloadURL();
    }catch(error){
      // An error occured
      print('Was not able to upload image to storage.');
    }

      // Now creating an instance of the pet profile in the 'PetProfiles' collection in Firebase
      FirebaseFirestore.instance.collection("Posts").add({
        'PetId': widget.documentId,
        'UserId': currentUser.email,
        'Description': descriptionController.text,
        'ImageUrl': imageUrl,
        'DatePosted': DateTime.now()
    });
    // Pop up back to the previous screen (Current User Page) after submitting
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
                // Placeholder or selected image
              _imageFile != null
                  ? Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(_imageFile!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Image.asset(
                      'Assets/Images/logo-placeholder.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Select Image'),
                ),
                SizedBox(height: 20),
                const Text("Upload a Post"),
                const SizedBox(height:25),
                // Every input widget uses the custom TextField component we made
                // Description Input
                MyTextField(controller: descriptionController, hintText: 'Post Description', obscureText: false),
                const SizedBox(height:15),
                // Submit Application Button
                MyButton(onTap: uploadPost, text: 'Upload Post'),
                const SizedBox(height:5),
              ],
            ),
          ),
        )
      )
    );
  }
}