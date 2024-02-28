import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saarthi/pages/get_started_page.dart';
import 'informative_page.dart';
import 'login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  RegistrationPage({Key? key}) : super(key: key);

  Future<List<String>> fetchCities(String state) async {
    // Replace this with your actual city data fetching logic
    // For demonstration, returning a list of cities based on the state
    List<String> cities = [];

    // Add logic to fetch cities based on the selected state
    if (state == 'Maharashtra') {
      cities = ['Mumbai', 'Pune', 'Nagpur'];
    } else if (state == 'Gujarat') {
      cities = ['Ahmedabad', 'Surat', 'Vadodara'];
    } else if (state == 'Rajasthan') {
      cities = ['Jaipur', 'Udaipur', 'Jodhpur'];
    }

    return cities;
  }

  Widget buildDropdown(String label, List<String> items, TextEditingController controller) {
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
        DropdownButtonFormField(
          value: items.first,
          items: items.map((item) {
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
              borderSide: BorderSide(color: Color.fromARGB(255, 94, 26, 117), width: 2),
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

  Widget buildStateDropdown() {
    return buildDropdown('State', ['Select', 'Maharashtra', 'Gujarat', 'Rajasthan'], stateController);
  }

  Widget buildCityDropdown() {
    return FutureBuilder(
      future: fetchCities(stateController.text),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<String> cities = snapshot.data!;
          return buildDropdown('City', cities, districtController);
        }
      },
    );
  }

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
                      buildTextField('Name', nameController, prefixIcon: Icons.person),
                      buildTextField('Age', ageController, prefixIcon: Icons.cake),
                      buildTextField('Gender', genderController, prefixIcon: Icons.person, dropdownItems: ['Select', 'Male', 'Female', 'Prefer not to say']),
                      buildStateDropdown(),
                      buildCityDropdown(),
                      buildTextField('Email ID', emailController, prefixIcon: Icons.message),
                      buildTextField('Enter Password', passwordController, obscureText: true, prefixIcon: Icons.lock),
                      buildTextField('Confirm Password', confirmPasswordController, obscureText: true, prefixIcon: Icons.lock),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildElevatedButton(context),
                          const SizedBox(width: 20),
                          buildOutlinedButton(context),
                        ],
                      ),
                      const SizedBox(height: 20),
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
                                'Create Account',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {bool obscureText = false, IconData? prefixIcon, List<String>? dropdownItems}) {
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
                borderSide: BorderSide(color: Color.fromARGB(255, 94, 26, 117), width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
          )
        else
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Enter your $label',
              prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 94, 26, 117), width: 2),
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
        String password = passwordController.text;
        String confirmPassword = confirmPasswordController.text;

        if (password != confirmPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Passwords do not match.'),
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }

        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: password,
          );

          String userId = userCredential.user!.uid;

          await FirebaseFirestore.instance.collection('doctors').doc(userId).set({
            'name': nameController.text,
            'age': ageController.text,
            'gender': genderController.text,
            'state': stateController.text,
            'city': districtController.text,
            'email': emailController.text,
          });

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Registration Successful'),
                content: Text('Congratulations, your registration was successful!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration failed: ${e.message}'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 73, 22, 101)),
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
        side: MaterialStateProperty.all(BorderSide(color: Color.fromARGB(255, 63, 25, 84))),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          'Skip for Now',
          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
  }
}
