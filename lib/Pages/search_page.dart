import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  // Temporary simple widget to show search page
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
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              // Align every widget on the center of the screen
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Search Page")
              ],
            ),
          ),
        ),
      ),
    );
  }
}