// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Pages/Adoption%20Pages/adoption_home_page.dart';
import 'package:pet_pallery/Pages/User%20Pages/curr_user_page.dart';
import 'package:pet_pallery/Pages/real_home_page.dart';
import 'package:pet_pallery/Pages/search_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List of page that will be shown with the navbar
  final List pages = [
    RealHomePage(),
    SearchPage(),
    AdoptionPage(),
    CurrentUserPage()
  ];

  int pageIndex = 0;

  // Method allows user to navigate between pages based on which tab they selected (goes by index)
  void navigateBar(int index){
    setState(() {
      pageIndex = index;
    });
  }

  // Building out our HomePage widget, very simplistic design for first code drop
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          // Calling method to change page
          onTap: navigateBar,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          // Navigation bar items that lets us go to a certain page when clicked on
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.pets), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
          ],
        ),
    );
  }
}