import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  // Function for when button is clicked on and the text inside the button
  final Function()? onTap;
  final String text;

  const MyButton({super.key, required this.onTap, required this.text});

  // Build of the button widget
  @override
  Widget build(BuildContext context) {
    // Allows button to be tapped on
    return GestureDetector(
      onTap: onTap,
      // Everything is within a container
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),)),
      ),
    );
  }
}