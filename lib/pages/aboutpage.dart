import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Saarthi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Saarthi Logo Image
            Image.asset(
              'assets/saarthilogo.png', // Replace with your image path
              height: 150,
              width: 150,
            ),
            SizedBox(height: 20),
            // Card with Saarthi Information
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Saarthi',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Saarthi is a mental health assessment app designed to provide early-stage screening of mental health disorders. Our mission is to help people identify potential mental health concerns and connect them with appropriate resources and support.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Key Features:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '- Early-stage screening of mental health disorders',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      '- Personalized recommendations for mental well-being',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      '- Resources and support for mental health challenges',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Back Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
