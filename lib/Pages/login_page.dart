// ignore_for_file: prefer_const_constructors

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:pet_pallery/Components/button.dart";
import "package:pet_pallery/Components/text_field.dart";

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers to handle the text users will input into the text fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Function to attempt to sign into an account that is registered within firebase
  void signIn () async{
    // Trying to sign in
    try{
      // Checking with users store in Firebase Auth
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    }
    // If an error occurs, tell the user the login was unsuccessful
    // Do not tell them why, leave it ambiguous for safety reasons
    on FirebaseAuthException catch(e) {
      displayMessage("Login Unsuccessful");
    }
  }

  // Function to display a message if there is an error logging in
  void displayMessage(String message){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      )
    );
  }

  // Structure to our Login Page widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Ensuring that none of our widgets our covered up behind anything on the layout of the phone
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              // Align every widget on the center of the screen
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image at the top of our page
                const Image(
                  image: AssetImage('Assets/Images/logo-placeholder.png'),
                  width: 300,
                ),

                const Text("Welcome Back to Pet Pallery!"),
                const SizedBox(height:25),
                // Both our email and password inputs are below
                MyTextField(controller: emailController, hintText: 'Enter Email', obscureText: false),
                const SizedBox(height:25),
                MyTextField(controller: passwordController, hintText: 'Enter Password', obscureText: true),
                const SizedBox(height:25),
                MyButton(onTap: signIn, text: 'Login'),
                const SizedBox(height:5),
                // Allow user to tap on text below to go and register a new account if they want to
                Row(
                  children: [
                    Text("Don't Have an Account? "),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text("Make an account today!", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),)
                      ),
                  ],
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}