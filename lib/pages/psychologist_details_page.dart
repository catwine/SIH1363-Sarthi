import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Psychologist {
  final String name;
  final String phoneNumber;
  // final String location;
  final String state;
  final String city;
  final String designation;
  final int yearsOfExperience;
  // bool availability; // Add availability property
  // double ratings; // Add ratings property


  Psychologist({
    required this.name,
    required this.phoneNumber,
    // required this.location,
    required this.state,
    required this.city,
    required this.designation,
    required this.yearsOfExperience,
    //  this.availability = false, // Default availability to false
    // this.ratings = 0.0, // Default ratings to 0.0
  });
} 

class MyRecommendationPage extends StatefulWidget {
  @override
  _MyRecommendationPageState createState() => _MyRecommendationPageState();
}

class _MyRecommendationPageState extends State<MyRecommendationPage> {

  // List<String> currentCities = [];
  List<Psychologist> psychologists = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // List<Psychologist> filteredPsychologists = []; // Define the list here

  @override
  void initState() {
    super.initState();
    // Set the initial cities based on the selected state
    // updateCities();
    initializePsychologists(); 
  }

  // void updateCities() {
  //   switch (selectedState) {
  //     case 'Maharashtra':
  //       currentCities = maharashtraCities;
  //       break;
  //     case 'Gujarat':
  //       currentCities = gujaratCities;
  //       break;
  //     case 'Rajasthan':
  //       currentCities = rajasthanCities;
  //       break;
  //     default:
  //       currentCities = otherCities;
  //       break;
  //   }
  // }

  

  void initializePsychologists() {
    psychologists = [
      Psychologist(
        name: 'Dr. John Doe',
        phoneNumber: '123-456-7890',
        state: 'Maharashtra',
        city: 'Mumbai',
        designation: 'Clinical Psychologist',
        yearsOfExperience: 10,
      ),
      Psychologist(
        name: 'Dr. Jane Smith',
        phoneNumber: '987-654-3210',
        state: 'Maharashtra',
        city : 'Pune',
        designation: 'Counseling Psychologist',
        yearsOfExperience: 8,
      ),
      Psychologist(
        name: 'Dr. William Smith',
        phoneNumber: '987-654-3210',
        state: 'Maharashtra',
        city: 'Nagpur',
        designation: 'Counseling Psychologist',
        yearsOfExperience: 8,
      ),
      Psychologist(
        name: 'Dr. Jon Smith',
        phoneNumber: '987-654-3210',
        state: 'Maharashtra',
        city: 'Nashik',
        designation: 'Counseling Psychologist',
        yearsOfExperience: 8,
      ),
      Psychologist(
        name: 'Dr. Emily Johnson',
        phoneNumber: '555-123-4567',
        state: 'Gujarat',
        city: 'Ahmedabad',
        designation: 'Child Psychologist',
        yearsOfExperience: 12,
      ),
      Psychologist(
        name: 'Dr. Jane Smith',
        phoneNumber: '987-654-3210',
        state: 'Gujarat',
        city: 'Surat',
        designation: 'Counseling Psychologist',
        yearsOfExperience: 8,
      ),
      Psychologist(
        name: 'Dr. Jane Smith',
        phoneNumber: '987-654-3210',
        state: 'Gujarat',
        city: 'Rajkot',
        designation: 'Counseling Psychologist',
        yearsOfExperience: 8,
      ),
      Psychologist(
        name: 'Dr. Jane Smith',
        phoneNumber: '987-654-3210',
        state: 'Gujarat',
        city: 'Vadodara',
        designation: 'Counseling Psychologist',
        yearsOfExperience: 8,
      ),
      Psychologist(
        name: 'Dr. Jane Smith',
        phoneNumber: '987-654-3210',
        state: 'Rajasthan',
        city: 'Jaipur',
        designation: 'Counseling Psychologist',
        yearsOfExperience: 8,
      ),
      Psychologist(
        name: 'Dr. Jane Smith',
        phoneNumber: '987-654-3210',
        state: 'Rajasthan',
        city: 'Jodhpur',
        designation: 'Counseling Psychologist',
        yearsOfExperience: 8,
      ),
      Psychologist(
        name: 'Dr. Jane Smith',
        phoneNumber: '987-654-3210',
        state: 'Rajasthan',
        city: 'Udaipur',
        designation: 'Counseling Psychologist',
        yearsOfExperience: 8,
      ),
      // Add more psychologists manually
    ];
    
  }

  //   void updatePsychologists() {
  //   setState(() {
  //     filteredPsychologists = psychologists
  //         .where((psychologist) =>
  //             psychologist.state == selectedState &&
  //             psychologist.city == selectedCity )
  //         .toList();
  //   });
  // }

  Future<void> _bookAppointment(Psychologist psychologist) async {
    try {
      await _firestore.collection('appointments').add({
        'psychologistName': psychologist.name,
        'psychologistPhoneNumber': psychologist.phoneNumber,
        'appointmentDate': DateTime.now(),
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Appointment Booked'),
            content: Text('Your appointment has been booked successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error booking appointment: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mental Health Professionals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mental Health Professionals',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
           
            SizedBox(height: 16.0),
            
          Expanded(
              child: ListView.builder(
                itemCount: psychologists.length,
                itemBuilder: (context, index) {
                  return PsychologistCard(
                    psychologist: psychologists[index],
                    onBookAppointment: () =>
                        _bookAppointment(psychologists[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PsychologistCard extends StatelessWidget {
  final Psychologist psychologist;
  final VoidCallback onBookAppointment;

  PsychologistCard({required this.psychologist,required this.onBookAppointment, });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              psychologist.name,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              
              'Phone Number: ${psychologist.phoneNumber}',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              
              'State: ${psychologist.state}',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              
              'City: ${psychologist.city}',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              
              'Designation: ${psychologist.designation}',
              style: TextStyle(fontSize: 16.0),
            ),
            // Text(
            //   'Availability: ${psychologist.availability ? "Available" : "Not Available"}',
            //   style: TextStyle(fontSize: 16.0),
            // ),
            Text(
              'Experience: ${psychologist.yearsOfExperience} years',
              style: TextStyle(fontSize: 16.0),
            ),
            // Text(
            //   'Ratings: ${psychologist.ratings}',
            //   style: TextStyle(fontSize: 16.0),
            // ),

            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: onBookAppointment,
              child: Text('Book an Appointment'),
            ),
           ],
        ),
      ),
    );
  }
} 




