import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saarthi/pages/get_started_page.dart';
import 'informative_page.dart';
import 'login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  RegistrationPage({Key? key}) : super(key: key);

  int progressValue = 0; // Tracks the progress value

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 200),

                      // Form Fields
                      buildTextField('Name', nameController,
                          prefixIcon: Icons.person),
                      buildTextField('Age', ageController,
                          prefixIcon: Icons.cake),
                      buildTextField('Gender', genderController,
                          prefixIcon: Icons.person,
                          dropdownItems: [
                            'Select',
                            'Male',
                            'Female',
                            'Others',
                            'Prefer not to say'
                          ]),
                      // buildDistrictDropdown(),
                      buildTextField('Email ID', emailController,
                          prefixIcon: Icons.message),
                      buildTextField('Enter Password', passwordController,
                          obscureText: true, prefixIcon: Icons.lock),
                      buildTextField(
                          'Confirm Password', confirmPasswordController,
                          obscureText: true, prefixIcon: Icons.lock),
                      const SizedBox(height: 30),

                      // Interactive Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildElevatedButton(context),
                          const SizedBox(width: 20),
                          buildOutlinedButton(context),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Clickable text to navigate to login page
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Already a user? Login',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
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
                          left: 140,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                ' Welcome',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 74, 56, 148),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Sign Up to continue',
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
                //         Positioned(
                //           top: 0,
                //           left: 00,
                //           child: Container(
                //             child: Image.asset(
                //                 'assets/saarthilogo.png', // Replace with the path to your PNG image
                //                 height: 90,
                //                 width: 90,
                //               ),
                //             height: 150,
                //             width: 150,
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.only(
                //               topLeft: Radius.circular(10),  // Customize the top left corner
                //               bottomRight: Radius.circular(85),  // Customize the bottom right corner
                // ),
                //             ),
                //             // Add any curved shape or decoration you desire
                //           ),
                //         ),
                //         Positioned(
                //           top: 20,
                //           right: 20,
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.end,
                //             children: [
                //               Text(
                //                 'Hello There!',
                //                 style: TextStyle(
                //                   fontSize: 8,
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.white,
                //                 ),
                //               ),
                //               Text(
                //                 'Sign Up to continue',
                //                 style: TextStyle(
                //                   fontSize: 14,
                //                   color: Colors.white,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {bool obscureText = false,
      IconData? prefixIcon,
      List<String>? dropdownItems}) {
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
        // Check if the field is gender and add a dropdown
        if (label.toLowerCase() == 'gender' && dropdownItems != null)
          DropdownButtonFormField(
            value: dropdownItems.first,
            items: dropdownItems.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (value) {
              controller.text = value.toString();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 94, 26, 117), width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
          )
        else
          // Otherwise, use a regular TextFormField with added validation
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.black),
            validator: (value) {
              if (label.toLowerCase() == 'name' &&
                  !RegExp(r"^[a-zA-Z]+$").hasMatch(value!)) {
                return 'Please enter only alphabets';
              }
              if (label.toLowerCase() == 'age' &&
                (int.tryParse(value!) == null ||
                    int.parse(value) <= 15 ||
                    int.parse(value) >= 150)) {
              return 'Please enter a valid age (greater than 15)';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Enter your $label',
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: Colors.grey)
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 94, 26, 117), width: 2),
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

  // Widget buildDistrictDropdown() {
  //   // You need to replace this with actual district data
  //   List<String> districts = ['Mumbai', 'Pune', 'Nagpur'];

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Text(
  //         'District (Maharashtra)',
  //         style: const TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.white,
  //         ),
  //       ),
  //       DropdownButtonFormField(
  //         value: districts.first,
  //         items: districts.map((district) {
  //           return DropdownMenuItem(
  //             value: district,
  //             child: Text(district),
  //           );
  //         }).toList(),
  //         onChanged: (value) {
  //           // Handle district selection
  //         },
  //         decoration: InputDecoration(
  //           border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(color: Color.fromARGB(255, 94, 26, 117), width: 2),
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           filled: true,
  //           fillColor: Colors.grey.shade100,
  //         ),
  //       ),
  //       const SizedBox(height: 20),
  //     ],
  //   );
  // }

  Widget buildElevatedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // Validate the passwords before proceeding with registration
        String password = passwordController.text;
        String confirmPassword = confirmPasswordController.text;

        if (password != confirmPassword) {
          // Passwords don't match, show an error to the user
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Passwords do not match.'),
              duration: Duration(seconds: 2),
            ),
          );
          return; // Don't proceed with registration
        }

        try {
          // Create user with email and password
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: password,
          );

          // Get the user ID
          String userId = userCredential.user!.uid;

          // Store user data in Firestore
          await FirebaseFirestore.instance.collection('users').doc(userId).set({
            'name': nameController.text,
            'age': ageController.text,
            'gender': genderController.text,
            'city': districtController.text, // Assuming 'district' is the city
            'email': emailController.text,
          });

          // Registration successful, show dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Registration Successful'),
                content:
                    Text('Congratulations, your registration was successful!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      // Navigate to the GetStartedPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GetStartedPage(),
                        ),
                      );
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } on FirebaseAuthException catch (e) {
          // Handle registration errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration failed: ${e.message}'),
              duration: Duration(seconds: 2),
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
          'Sign Up',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget buildOutlinedButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        // Navigate to the InformativePage
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => InformativePage(),
          ),
        );
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        side: MaterialStateProperty.all(
            BorderSide(color: Color.fromARGB(255, 63, 25, 84))),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          'Skip for Now',
          style: TextStyle(
              fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
  }
}
