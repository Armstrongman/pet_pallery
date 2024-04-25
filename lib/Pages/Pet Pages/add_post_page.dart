import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Components/button.dart';
import 'package:pet_pallery/Components/text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddPostPage extends StatefulWidget {
  final String documentId;
  const AddPostPage({super.key, required this.documentId});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  // Getting current user for certain needed user information
  final currentUser = FirebaseAuth.instance.currentUser!;
  // Getting a reference to the directory in firebase storage where the image will be uploaded to
  Reference referenceDirImages=FirebaseStorage.instance.ref().child('posts');

  // Initializing some variables
  File? _imageFile;
  final picker = ImagePicker();
  final descriptionController = TextEditingController();
  String imageUrl = '';

  // Method to pick an image from the phone
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // If an image was picked, update the path of the file
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Method to upload the post to the database
  Future<void> uploadPost() async {
    if (_imageFile == null) return; // No image selected

    // Making sure the name of the file is unique
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

      // Now creating an instance of the post in the 'Posts' collection in Firebase
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
                // Description Input
                MyTextField(controller: descriptionController, hintText: 'Post Description', obscureText: false),
                const SizedBox(height:15),
                // Submit Post Button
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