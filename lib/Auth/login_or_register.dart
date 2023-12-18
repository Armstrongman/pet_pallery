import 'package:flutter/material.dart';
import 'package:pet_pallery/Pages/login_page.dart';
import 'package:pet_pallery/Pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Bool to be used to determine what page needs to be shown
  bool showLoginPage = true;

  // Function that allows the user to switch pages between the login and register pages
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  // Widget is basically either showing the login or register page based on the state of the bool
  // The on tap functions allow the user to continue to switch pages if they want to
  @override
  Widget build(BuildContext context) {
    // If the bool is true, show the login page
    if (showLoginPage){
      return LoginPage(onTap: togglePages);
    }
    // Else show the Register Page
    else{
      return RegisterPage(onTap: togglePages);
    }
  }
}