// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RealHomePage extends StatefulWidget {
  const RealHomePage({super.key});

  @override
  State<RealHomePage> createState() => _RealHomePageState();
}

class _RealHomePageState extends State<RealHomePage> {
  @override
  // Temporary simple widget to show the home page
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              // Align every widget on the center of the screen
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Home Page")
              ],
            ),
          ),
        ),
      ),
    );
  }
}