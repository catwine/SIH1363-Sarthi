import 'package:flutter/material.dart';
import 'descriptive_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AssessmentPage extends StatefulWidget {
  @override
  _AssessmentPageState createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _assessmentCollection =
      FirebaseFirestore.instance.collection('assessments');

  Map<String, int> disorderRanking = {};
  Map<String, int> disorderCount = {
    "Anxiety": 0,
    "Depression": 0,
    "Alcohol Abuse": 0,
    "Internet Addiction": 0,
    "No disorder detected": 0,
  };

  List<Map<String, dynamic>> questions = [
    {
      "question":
          "Have you noticed any of the following changes in your sleep patterns recently ?",
      "image": "assets/cq1.png", // Add image path
      "options": [
        "I find it difficult to fall asleep",
        "I tend to Oversleep",
        "I find it difficult to get a good quality sleep",
        "My sleep is disrupted due to excessive screen time",
        "I donot relate to any of the mentioned conditions",
      ]
    },
    {
      "question":
          "When thinking about your day-to-day activities, have you observed any variations in your mood recently?",
      "image": "assets/cq2.png",
      "options": [
        "I constantly feel sad and hopeless",
        "My mood fluctuates, particularly influenced by external factors or substances",
        "I have regular mood swings based on online experiences",
        "I have not observed any of the mentioned condition",
        "I often feel restless and worried",
      ]
    },
    {
      "question":
          "Do you feel there have been any noticeable changes in the way you look or how your body feels to you recently?",
      "image": "assets/cq3.png",
      "options": [
        "Migraines and Fatigue",
        "Abdominal pain and gastric issues",
        "Potential weight gain or loss",
        "I have not noticed any physical changes",
        "Changes in appetite and energy levels"
      ]
    },
    {
      "question": "What helps you relax the most ?",
      "image": "assets/cq4.png",
      "options": [
        "I have trouble relaxing",
        "I just sleep a lot",
        "I surf through social media to relax",
        "I practice other relaxation techniques",
        "Engaging in recreational drinking is my preferred choice"
      ]
    },
    {
      "question":
          "Please identify any of the following issues that you may have experienced as a result of certain behaviours or conditions.",
      "image": "assets/cq5.png",
      "options": [
        "I have started feeling a lot more anxious than usual",
        "I am experiencing difficulty performing daily tasks",
        "I have been neglecting a few important things",
        "I have seen a decrease in productivity due to excessive online use",
        "None of the above"
      ]
    },
    {
      "question":
          "Have you noticed any difficulties in your relationships recently?",
      "image": "assets/cq6.png",
      "options": [
        "I have difficulty forming and maintaining relationships as I feel afraid of commitments as if something awful may happen",
        "I feel that I am a failure and I have let my family and friends down",
        "I often get into heated arguments  with my family or feel like isolating myself after I consume alcohol",
        "I have not noticed any of the above",
        "Yes, My close ones do complain about my binge-watching/gaming/channel surfing/chatting/social media use "
      ]
    },
    {
      "question":
          "Have you noticed any of the following changes in your behaviours?",
      "image": "assets/cq7.png",
      "options": [
        "It is hard for me to concentrate even while watching television",
        "Drinking alcoholic beverages on a regular basis have become part of my life",
        "I constantly keep checking my social accounts",
        "No, I have not noticed any of the above changes",
        "I constantly worry about different things"
      ]
    },
    {
      "question": "How do you tend to cope with stress and pain?",
      "image": "assets/cq8.png",
      "options": [
        "I avoid social interaction to stay away from nervousness",
        "I don't feel like eating at all/I just eat too much",
        "I tend to consume more alcohol to get relief",
        "I often watch web series and shows to keep myself away from other thoughts",
        "None of the above"
      ]
    },
    {
      "question":
          "Which of the following behaviours do you keep going back to?",
      "image": "assets/cq9.png",
      "options": [
        "I love to stay online or engage in specific online activities",
        "I become extra cautious about each and every situation which may sometimes lead to avoiding the situation completely",
        "I crave isolation and social withdrawal",
        "I have a strong urge to consume alcohol, especially in triggering situations",
        "None of the above"
      ]
    },
  ];

  Map<String, String> question1Mappings = {
    "I find it difficult to fall asleep": "Anxiety",
    "I tend to Oversleep": "Depression",
    "I find it difficult to get a good quality sleep": "Alcohol Abuse",
    "My sleep is disrupted due to excessive screen time": "Internet Addiction",
    "I donot relate to any of the mentioned conditions": "No disorder detected"
  };

  Map<String, String> question2Mappings = {
    "I often feel restless and worried": "Anxiety",
    "I constantly feel sad and hopeless": "Depression",
    "My mood fluctuates, particularly influenced by external factors or substances":
        "Alcohol Abuse",
    "I have regular mood swings based on online experiences":
        "Internet Addiction",
    "I have not observed any of the mentioned condition": "No disorder detected"
  };

  Map<String, String> question3Mappings = {
    "Migraines and Fatigue": "Anxiety",
    "Changes in appetite and energy levels": "Depression",
    "Abdominal pain and gastric issues": "Alcohol Abuse",
    "Potential weight gain or loss": "Internet Addiction",
    "I have not noticed any physical changes": "No disorder detected"
  };

  Map<String, String> question4Mappings = {
    "I have trouble relaxing": "Anxiety",
    "I just sleep a lot": "Depression",
    "Engaging in recreational drinking is my preferred choice": "Alcohol Abuse",
    "I surf through social media to relax": "Internet Addiction",
    "I practice other relaxation techniques": "No disorder detected"
  };

  Map<String, String> question5Mappings = {
    "I have started feeling a lot more anxious than usual": "Anxiety",
    "I am experiencing difficulty performing daily tasks": "Depression",
    "I have been neglecting a few important things": "Alcohol Abuse",
    "I have seen a decrease in productivity due to excessive online use":
        "Internet Addiction",
    "None of the above": "No disorder detected"
  };

  Map<String, String> question6Mappings = {
    "I have difficulty forming and maintaining relationships as I feel afraid of commitments as if something awful may happen":
        "Anxiety",
    "I feel that I am a failure and I have let my family and friends down":
        "Depression",
    "I often get into heated arguments  with my family or feel like isolating myself after I consume alcohol":
        "Alcohol Abuse",
    "Yes, My close ones do complain about my binge-watching/gaming/channel surfing/chatting/social media use ":
        "Internet Addiction",
    "I have not noticed any of the above": "No disorder detected"
  };

  Map<String, String> question7Mappings = {
    "I constantly worry about different things": "Anxiety",
    "It is hard for me to concentrate even while watching television":
        "Depression",
    "Drinking alcoholic beverages on a regular basis have become part of my life":
        "Alcohol Abuse",
    "I constantly keep checking my social accounts": "Internet Addiction",
    "No, I have not noticed any of the above changes": "No disorder detected"
  };

  Map<String, String> question8Mappings = {
    "I avoid social interaction to stay away from nervousness": "Anxiety",
    "I don't feel like eating at all/I just eat too much": "Depression",
    "I tend to consume more alcohol to get relief": "Alcohol Abuse",
    "I often watch web series and shows to keep myself away from other thoughts":
        "Internet Addiction",
    "None of the above": "No disorder detected"
  };

  Map<String, String> question9Mappings = {
    "I become extra cautious about each and every situation which may sometimes lead to avoiding the situation completely":
        "Anxiety",
    "I crave isolation and social withdrawal": "Depression",
    "I have a strong urge to consume alcohol, especially in triggering situations":
        "Alcohol Abuse",
    "I love to stay online or engage in specific online activities":
        "Internet Addiction",
    "None of the above": "No disorder detected"
  };

  // Map<String, String> question10Mappings = {
  //   "Constantly distracted by worries": "Anxiety",
  //   "Struggling to concentrate": "Depression",
  //   "Impaired judgment": "Substance Abuse",
  //   "Easily distracted by the online world": "Internet Addiction",
  //   "None of the above": "No disorder detected"
  // };

  // Map<String, String> question11Mappings = {
  //   "Anxious thoughts and concerns": "Anxiety",
  //   "Persistent sadness or despair": "Depression",
  //   "Cravings for substances": "Substance Abuse",
  //   "Engaging in online activities": "Internet Addiction",
  //   "None of the above": "No disorder detected"
  // };

  // Map<String, String> question12Mappings = {
  //   "Anxious thoughts keeping you awake": "Anxiety",
  //   "Dwelling on sadness or regrets": "Depression",
  //   "Thoughts related to substances": "Substance Abuse",
  //   "Late-night online interactions": "Internet Addiction",
  //   "None of the above": "No disorder detected"
  // };

  List<String> selectedOptions =
      List.filled(12, ""); // Initialize with empty strings for each question

  int currentQuestionIndex = 0;
  String selectedOption = "";

  Widget build(BuildContext context) {
    double progress = (currentQuestionIndex + 1) / questions.length;

    return SafeArea(
      child: Scaffold(
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
          child: Column(
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 73, 22, 101),
                ),
                minHeight: 15,
              ),
              Expanded(
                child: ListView(
                  children: [
                    buildQuestionCard(questions[currentQuestionIndex]),
                    SizedBox(height: 80.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (currentQuestionIndex > 0) {
                              setState(() {
                                currentQuestionIndex -= 1;
                                selectedOption = "";
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 73, 22, 101),
                          ),
                          child: Text('Back'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (currentQuestionIndex < questions.length - 1) {
                              setState(() {
                                currentQuestionIndex += 1;
                                selectedOption = "";
                              });
                            } else {
                              // Last question, show result or submit the test
                              submitTest();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 73, 22, 101),
                          ),
                          child: Text(
                            currentQuestionIndex < questions.length - 1
                                ? 'Next'
                                : 'Submit',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuestionCard(Map<String, dynamic> question) {
    return Card(
      margin: EdgeInsets.all(15.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            if (question
                .containsKey("image")) // Check if the question has an image
              Image.asset(
                question["image"],
                height: 100, // Adjust the height as needed
              ),
            Text(
              question['question'],
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30.0),
            Row(
              children: [
                buildOptionSquare(question['options'][0]),
                buildOptionSquare(question['options'][1]),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              children: [
                buildOptionSquare(question['options'][2]),
                buildOptionSquare(question['options'][3]),
              ],
            ),
            Row(
              children: [
                buildOptionSquare(question['options'][4]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOptionSquare(String option) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          updateDisorderCount(option);
          setState(() {
            selectedOption = option;
          });
        },
        child: Container(
          height: 100.0, // Set a fixed height for the container
          margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border: Border.all(
                color: Color.fromARGB(255, 48, 33, 106)), // Add border
            borderRadius: BorderRadius.circular(8.0), // Add border radius
            color: selectedOption == option
                ? Color.fromARGB(255, 166, 150, 230)
                : Colors.white,
          ),
          child: Center(
            child: Text(
              option,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  void updateDisorderCount(String option) {
    String disorder = getDisorderMapping(option);
    if (disorder.isNotEmpty) {
      setState(() {
        disorderCount[disorder] = (disorderCount[disorder] ?? 0) + 1;

        disorderRanking[option] = (disorderRanking[option] ?? 0) + 1;
      });
    }
  }

  String getDisorderMapping(String option) {
    if (question1Mappings.containsKey(option)) {
      return question1Mappings[option]!;
    } else if (question2Mappings.containsKey(option)) {
      return question2Mappings[option]!;
    } else if (question3Mappings.containsKey(option)) {
      return question3Mappings[option]!;
    } else if (question4Mappings.containsKey(option)) {
      return question4Mappings[option]!;
    } else if (question5Mappings.containsKey(option)) {
      return question5Mappings[option]!;
    } else if (question6Mappings.containsKey(option)) {
      return question6Mappings[option]!;
    } else if (question7Mappings.containsKey(option)) {
      return question7Mappings[option]!;
    } else if (question8Mappings.containsKey(option)) {
      return question8Mappings[option]!;
    } else if (question9Mappings.containsKey(option)) {
      return question9Mappings[option]!;
      // } else if (question10Mappings.containsKey(option)) {
      //   return question10Mappings[option]!;
      // } else if (question11Mappings.containsKey(option)) {
      //   return question11Mappings[option]!;
      // } else if (question12Mappings.containsKey(option)) {
      //   return question12Mappings[option]!;
    }
    return "";
  }

  Future<void> submitTest() async {
    // Get the currently logged-in user
    User? user = _auth.currentUser;

    if (user != null) {
      // Store user assessment data in Firestore under the user's unique identifier
      CollectionReference userAssessments =
          _firestore.collection('userAssessments');
      DocumentReference userDocument = userAssessments.doc(user.uid);

      // Create a subcollection named "selectedOptions" for the user
      CollectionReference selectedOptionsCollection =
          userDocument.collection('selectedOptions');

      // Add a document with the selected options
      await selectedOptionsCollection.add({
        'timestamp': FieldValue.serverTimestamp(),
        'disorderCount': disorderCount,
        'disorderRanking': disorderRanking,
      });

      // Print the counts of all disorders
      disorderCount.forEach((disorder, count) {
        print("$disorder count: $count");
      });
      // Print the ranking of selected options
      disorderRanking.forEach((option, count) {
        print("$option ranking: $count");
      });
      // Predicted disorder
      String result =
          disorderCount.entries.reduce((a, b) => a.value > b.value ? a : b).key;

      if (result.isNotEmpty) {
        // Print the most marked disorder
        print("Most Marked Disorder: $result");
        // Navigate to the descriptive test page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DescriptiveTestPage(predictedDisorder: result),
          ),
        );
      } else {
        // Handle case where result is empty (no disorder detected)
        // You can display an error message or handle it as per your requirements
        print("No disorder detected");
      }
    }
  }
}
