import 'package:flutter/material.dart';
import 'package:saarthi/pages/psychologist_details_page.dart';
import 'AssessmentPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'aboutpage.dart';
import 'chatbot.dart';
import 'informative_page.dart';
import 'landing_page.dart';

class User {
  String userId;
  String userName;

  User({required this.userId, required this.userName});

  static Future<User?> fetchUserData(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      return User(userId: userId, userName: userSnapshot['name'] ?? "Guest");
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class GetStartedPage extends StatefulWidget {
  final User? user;

  GetStartedPage({Key? key, this.user}) : super(key: key);

  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  late String userName = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      if (widget.user != null) {
        setState(() {
          userName = capitalizeFirstLetter(widget.user!.userName);
        });
      } else {
        User? currentUser = await User.fetchUserData(
          FirebaseAuth.instance.currentUser!.uid,
        );

        if (currentUser != null) {
          setState(() {
            userName = capitalizeFirstLetter(currentUser.userName);
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return '';
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 157, 174, 245),
                Color.fromARGB(255, 74, 56, 148),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        size: 30,
                        color: Color.fromARGB(255, 19, 9, 59),
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                        _showDrawer();
                        // Handle user icon click
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Hello $userName ! ', // Replace with actual user name
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 19, 9, 59),
                  ),
                ),
                SizedBox(height: 50),
                Column(
                  children: [
                    buildFeatureCard(
                      'Take Self Assessment',
                      'Let\'s quickly take this personal health test before we get started',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssessmentPage(),
                          ),
                        );
                      },
                      'assets/gettingstarted1.png',
                    ),
                    buildFeatureCard(
                      'Know About Disorders',
                      'Explore informative content about mental health disorders',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InformativePage(),
                          ),
                        );
                        // Handle Know about disorders click
                      },
                      'assets/gettingstarted2.png',
                    ),
                    buildFeatureCard(
                      'Have a chat',
                      'Explore informative content about mental health disorders',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(),
                          ),
                        );
                        // Handle Know about disorders click
                      },
                      'assets/gettingstarted2.png',
                    ),
                    buildFeatureCard(
                      'Nearby Mental Health Professionals',
                      'For assistance',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyRecommendationPage(),
                          ),
                        );
                        // Handle Nearby Psychologists click
                      },
                      'assets/gettingstarted3.png',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        drawer: buildDrawer(),
      ),
    );
  }

  // This the code for app drawer

  void _showDrawer() {
    Scaffold.of(context).openDrawer();
  }

  Drawer buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          // DrawerHeader(
          //   decoration: BoxDecoration(
          //     color: Colors.blue,
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     // children: [
          //     //   CircleAvatar(
          //     //     radius: 30,
          //     //     // You can add a user's profile picture here
          //     //   ),
          //     //   SizedBox(height: 70),
          //     //   Text(
          //     //     userName,
          //     //     style: TextStyle(
          //     //       color: Colors.white,
          //     //       fontSize: 20,
          //     //     ),
          //     //   ),
          //     // ],
          //   ),
          // ),
          SizedBox(height: 30),
          ListTile(
            title: Text('Test History'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Navigate to the Test History page
              // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => TestHistoryPage()));
            },
          ),
          ListTile(
            title: Text('Chat with Chatbot'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Know More about Disorders'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InformativePage()),
              ); // Close the drawer
              // Navigate to the Know More about Disorders page
              // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => DisordersPage()));
            },
          ),
          ListTile(
            title: Text('About'),
           onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              ); // Close the drawer
              // Navigate to the Know More about Disorders page
              // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => DisordersPage()));
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Perform logout and navigate to LandingPage
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildFeatureCard(
      String title, String description, VoidCallback onTap, String imagePath) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 08, vertical: 18),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  height: 1.8,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 74, 56, 148),
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 74, 56, 148),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
