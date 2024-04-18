import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Components/button.dart';
import 'package:pet_pallery/Components/text_field.dart';

class RegisterPage extends StatefulWidget {
  // Function for when the bottom text is tapped on
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controllers fo each of our input field
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final cityStateController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Function to set up a user in Firebase Auth & Firestore
  void signUp() async {
    // If the passwords dont match, have a display message telling the user that
    if (passwordController.text != confirmPasswordController.text){
      displayMessage("The passwords do not match");
      return;
    }

    // Try to make a new user
    try{
      // Creating the user in Firebase authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);

      // Now creating an instance of the user in the Users collection in Firebase
      FirebaseFirestore.instance.collection("Users")
      .doc(userCredential.user!.email)
      .set({
        'username' : usernameController.text,
        'City State' : cityStateController.text
      });
    // If an error does occur, catch it
    } on FirebaseAuthException catch (e) {
      displayMessage(e.code);
    }
  }

    // Function to display an error message if user could not make an account
    void displayMessage(String message){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      )
    );
  }


  // Structure of our register page widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // This ensures that none of the widgets on this page are covered up by elements of the phones screen
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              // Center everything on the center of the page
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image showing a temporary place holder logo
                const Image(
                  image: AssetImage('Assets/Images/pet-pallery-logo.png'),
                  width: 300,
                ),

                const Text("Account Creation"),
                const SizedBox(height:25),
                // Every input widget uses the custom TextField component we made
                // Email Input
                MyTextField(controller: emailController, hintText: 'Enter Email', obscureText: false),
                const SizedBox(height:15),
                // Username input
                MyTextField(controller: usernameController, hintText: 'Enter Username', obscureText: false),
                const SizedBox(height:15),
                // City State Input
                MyTextField(controller: cityStateController, hintText: 'Enter a City and State', obscureText: false),
                const SizedBox(height:15),
                // Password Input
                MyTextField(controller: passwordController, hintText: 'Enter Password', obscureText: true),
                const SizedBox(height:15),
                // Confirm Password Input
                MyTextField(controller: confirmPasswordController, hintText: 'Confirm Password', obscureText: true),
                const SizedBox(height:25),
                // Sign Up Button
                MyButton(onTap: signUp, text: 'Register'),
                const SizedBox(height:5),
                // Text below so that user can sign in if they want to
                Row(
                  children: [
                    Text("Already Have an Account? "),
                    // Will work to basically send user to the Login page if tapped on
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text("Login Here!", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),)
                      ),
                  ],
                ),
              ],
            ),
          ),
          ),
      )
    );
  }
}