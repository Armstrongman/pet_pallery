import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_pallery/Auth/auth.dart';
import 'package:pet_pallery/Pages/Adoption%20Pages/adoption_home_page.dart';
import 'package:pet_pallery/Pages/User%20Pages/curr_user_page.dart';
import 'package:pet_pallery/Pages/home_page.dart';
import 'package:pet_pallery/Pages/search_page.dart';
import 'package:pet_pallery/firebase_options.dart';


void main() async {
  // Making sure firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.highContrastLight(primary: Colors.orange)),
      debugShowCheckedModeBanner: false,
      // Our hompage is set to AuthPage checking to see whether the user is signed in or not
      home: AuthPage(),
      routes: {
        '/homepage' :(context) => HomePage(),
        '/searchpage':(context) => SearchPage(),
        '/adoptionpage':(context) => AdoptionPage(),
        '/curruserpage':(context) => CurrentUserPage(),
      }
    );
  }
}