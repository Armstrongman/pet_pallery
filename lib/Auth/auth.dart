import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Auth/login_or_register.dart';
import 'package:pet_pallery/Pages/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  // Auth is not an actual page, but it does decide what exact page/widget should be shown based off of certain conditions
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // If the user is signed in, show the home page for the user
          if (snapshot.hasData){
            return HomePage();
          }
          // If they are not signed it, show the user the Login page when they open the app
          else{
            return const LoginOrRegister();
          }
        },
      )
    );
  }
}