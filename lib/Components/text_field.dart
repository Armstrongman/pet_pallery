// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class MyTextField extends StatelessWidget {
  // Attributes to be passed into this widget
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;


  const MyTextField({super.key, required this.controller, required this.hintText, required this.obscureText});

  // Building of a custom text field
  @override
  Widget build(BuildContext context) {
    return TextField(
      // Seeing what the controller is that is attached to an instance of the text field
      controller: controller,
      // Bool to determine whether we want the text to be hidden or not
      obscureText: obscureText,
      // Customizing the text field to our liking
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[700])
      ),
    );
  }
}