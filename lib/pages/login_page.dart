import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saarthi/pages/registration_page.dart';
import 'get_started_page.dart';
import 'registration_page.dart';
import 'get_started_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 157, 174, 245),
                    Color.fromARGB(255, 74, 56, 148),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/saarthilogo.png', // Replace with the path to your PNG image
                            height: 150,
                            width: 150,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 155,
                      left: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            ' Welcome Back!',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 74, 56, 148),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Login to continue',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 74, 56, 148),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                        height: 250), // Adjust the space based on your needs

                    // Form Fields
                    buildTextField('Email ID', emailController,
                        prefixIcon: Icons.email),
                    buildTextField('Password', passwordController,
                        obscureText: true, prefixIcon: Icons.lock),
                    const SizedBox(height: 30),

                    // Interactive Buttons
                    buildElevatedButton(context),
                    const SizedBox(height: 20),
                    buildSignUpText(
                        context), // Use the SignUpText widget from the registration page
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {bool obscureText = false, IconData? prefixIcon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Enter your $label',
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: Colors.grey)
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromARGB(255, 94, 26, 117), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildElevatedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // Validate the login credentials
        String email = emailController.text;
        String password = passwordController.text;

        try {
          // Sign in the user with Firebase Authentication
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          // Print the user information
          print('User ID: ${userCredential.user?.uid}');
          print('Email: ${userCredential.user?.email}');

          // Navigate to the GetStartedPage after a successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => GetStartedPage(),
            ),
          );
        } on FirebaseAuthException catch (e) {
          // Handle errors such as invalid credentials, user not found, etc.
          print('Firebase Auth Error: ${e.message}');

          // Show a SnackBar with an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invalid email or password. Please retry.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Color.fromARGB(255, 73, 22, 101)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          'Log In',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget buildSignUpText(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the registration page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegistrationPage(),
          ),
        );
      },
      child: Text(
        'New User? Sign Up',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
