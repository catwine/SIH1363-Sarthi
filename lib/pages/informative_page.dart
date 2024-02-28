import 'package:flutter/material.dart';
import 'package:saarthi/pages/anxiety.dart';
import 'package:saarthi/pages/depression.dart';
import 'package:saarthi/pages/internetaddiction.dart';
import 'package:saarthi/pages/substanceabuse.dart';
import 'landing_page.dart';

class InformativePage extends StatelessWidget {
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
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                DisorderCard(
                  title: 'Anxiety',
                  description:
                      'Anxiety disorders are a group of mental disorders characterized by significant feelings of anxiety and fear. These feelings may cause physical symptoms, such as a racing heart and shakiness.',
                  icon: Icons.sentiment_neutral,
                  color: Color.fromARGB(255, 74, 56, 148),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnxietyPage(),
                      ),
                    );
                  },
                ),
                DisorderCard(
                  title: 'Depression',
                  description:
                      'Depression is a mood disorder that causes persistent feelings of sadness and loss of interest. It can lead to various emotional and physical problems and can decrease a person’s ability to function at work and at home.',
                  icon: Icons.sentiment_very_dissatisfied,
                  color: Color.fromARGB(255, 74, 56, 148),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DepressionPage(),
                      ),
                    );
                  },
                ),
                DisorderCard(
                  title: 'Substance Abuse',
                  description:
                      'Substance abuse, also known as drug abuse, is a patterned use of a drug in which the user consumes the substance in amounts or with methods that are harmful to themselves or others.',
                  icon: Icons.local_bar,
                  color: Color.fromARGB(255, 74, 56, 148),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubstanceAbuse(),
                      ),
                    );
                  },
                ),
                DisorderCard(
                  title: 'Internet Addiction',
                  description:
                      'Internet addiction disorder refers to the problematic use of the internet, including social media, online gaming, and excessive browsing, that impacts daily life and well-being.',
                  icon: Icons.wifi,
                  color: Color.fromARGB(255, 74, 56, 148),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InternetAddictionPage(),
                      ),
                    );
                  },
                ),
                // ... Repeat for other disorder cards
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DisorderCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  DisorderCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,  // Set the background color to white
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color.fromARGB(255, 74, 56, 148)),  // Set the border color to dark purple
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                color: color,
                size: 40,
              ),
            ),
            title: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 74, 56, 148)),  // Set the text color to dark purple
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 74, 56, 148)),  // Set the text color to dark purple
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: onPressed,
            child: Text('Know More'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 74, 56, 148)),  // Set the button background color to dark purple
            ),
          ),
        ],
      ),
    );
  }
}


