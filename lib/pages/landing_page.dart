import 'package:flutter/material.dart';
import 'package:saarthi/pages/registration_page.dart';
import 'package:saarthi/pages/informative_page.dart';
import 'package:saarthi/pages/skipnow.dart';
import 'login_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 157, 174, 245),
                Color.fromARGB(255, 74, 56, 148)
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Logo and Title
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors
                                .white, // Change the border color as needed
                            width: 2.0, // Change the border width as needed
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/saarthi_logo.png', // Replace with the path to your PNG image
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Add some spacing
                const SizedBox(height: 20),

                // "Sign Up" button with animation
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(
                        255, 252, 252, 252), // Adjusted button color
                    padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12), // Adjusted horizontal padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 74, 56, 148),
                    ),
                  ),
                ),

                // Add some spacing
                const SizedBox(height: 20),

                // Sign Up As A User
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RegistrationPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(
                        255, 255, 255, 255), // Adjusted button color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Sign Up As A User',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 74, 56, 148),
                    ),
                  ),
                ),


                 // Add some spacing
                // const SizedBox(height: 20),

                // // Sign Up As A Professional
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) => RegistrationPage(),
                //       ),
                //     );
                //   },
                //   style: ElevatedButton.styleFrom(
                //     primary: Color.fromARGB(
                //         255, 255, 255, 255), // Adjusted button color
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 20, vertical: 12),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                //   child: const Text(
                //     'Sign Up As A Professional',
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 18,
                //       color: Color.fromARGB(255, 74, 56, 148),
                //     ),
                //   ),
                // ),

                // Add some spacing
                const SizedBox(height: 20),

                // Continue without Login
                // Login button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SkipPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent, // Adjusted button color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Skip for now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),

                // Features or Additional Info
                Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    const Text(
                      'Your personal guide to better mental health.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    // Add some spacing
                    // const SizedBox(height: 20),

                    // PNG image towards the end of the page
                    Image.asset(
                      'assets/landingpage1.png', // Replace with the path to your PNG image
                      height: 250,
                      width: 270,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
