import 'package:flutter/material.dart';
import 'package:saarthi/pages/landing_page.dart';
import 'package:saarthi/pages/registration_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCjrlkppNPn9rLbuCQzxg01xiFQpWskM6A",
            appId: "1:556310874584:android:c6c5ff3bc31b6fd7290aad",
            messagingSenderId: "556310874584",
            projectId: "saarthi-31a78"));

    print('Firebase initialized successfully!');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saarthi - Your Own Companion',
      debugShowCheckedModeBanner: false, // Set this to false
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => const LandingPage(), // Landing page route
        '/registration': (context) =>
            RegistrationPage(), // Registration page route
      },
    );
  }
}
