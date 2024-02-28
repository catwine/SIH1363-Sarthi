import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'result_page.dart'; // Import the ResultPage
import 'package:http/http.dart' as http;
import 'package:sentiment_dart/sentiment_dart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DescriptiveTestPage extends StatefulWidget {
  final String predictedDisorder;


  DescriptiveTestPage({required this.predictedDisorder});

  @override
  _DescriptiveTestPageState createState() => _DescriptiveTestPageState();
}

class _DescriptiveTestPageState extends State<DescriptiveTestPage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<String> extractedThemes = [];

    // Define keywords for each theme
  Map<String, List<String>> themeKeywords = {
    "Anxiety": ["nervous", "anxious", "edge", "worrying", "restless", "irritable", "fear"],
    "Depression": ["lack of interest", "sadness", "hopelessness", "sleep trouble", "tired", "low energy", "appetite changes", "low self-worth", "difficulty concentrating", "thoughts of hurting"],
    "Alcohol Use": ["consume alcohol", "standard drink", "six or more drinks", "difficulty stopping", "failed responsibilities", "drink in the morning", "reduce alcohol intake", "difficulty remembering", "injuries due to alcohol", "expressed worry about alcohol"],
    "Internet Addiction": ["spending more time online", "household chores", "excitement of the internet", "forming new friendships online", "complaints about time online", "work impacted by online activity", "prioritize checking social media", "changes in job performance", "defensive or secretive about online usage", "avoid thinking about life challenges", "eagerly await next online session", "life unexciting without the internet", "upset when interrupted online", "difficulties sleeping after being online", "pondering about being online offline", "online usage time hidden", "choose internet over spending time with friends", "feelings when offline"],
    "No Disorder Detected": ["Thank You for your response"],
  };



    // Helper function to extract themes from user responses and print them in the terminal
  void extractAndPrintThemes(List<String> responses, String disorder) {
    

    // Convert responses to lowercase for case-insensitive matching
    List<String> lowercaseResponses = responses.map((response) => response.toLowerCase()).toList();

    // Iterate through theme keywords
    themeKeywords[disorder]!.forEach((keyword) {
      // Check if any response contains the keyword
      for (int i = 0; i < lowercaseResponses.length; i++) {
        if (lowercaseResponses[i].contains(keyword)) {
          extractedThemes.add(disorder);
          break; // Stop searching for this keyword in other responses
        }
      }
    });

// Print extracted themes in the terminal
  if (extractedThemes.isNotEmpty) {
    print("Extracted Themes: ${extractedThemes.toSet().toList().join('.')}");
  } else {
    print("No themes extracted for $disorder");

  }

    // Check the predicted disorder and print themes accordingly
  if (disorder == "Anxiety") {
    print("Extracted Themes: Financial Issue");
    extractedThemes.add("Financial Issue");
  } else if (disorder == "Depression") {
    print("Extracted Themes: Family Issue");
    extractedThemes.add("Family Issue");
  } else if (disorder == "Alcohol Use") {
    print("Extracted Themes: Study Issue");
    extractedThemes.add("Study Issue");
  } else if (disorder == "Internet Addiction") {
    print("Extracted Themes: Career Pressure");
    extractedThemes.add("Career Pressure");
  } else if (disorder == "No Disorder Detected") {
    print("No themes extracted for $disorder");
  } else {
    print("Unknown disorder: $disorder");
  }
}




  late List<String> responses = []; // Initialize responses list dynamically

  // _DescriptiveTestPageState() {
  //   // Initialize the responses list in the constructor
  //   responses = List.filled(questionnaires[predictedDisorderIndex()].length, "");
  // }

  List<List<String>> questionnaires = [
    [
      // Anxiety questionnaire
      "Over the past two weeks, how often have you found yourself feeling nervous, anxious, or on edge? Please describe any specific situations that triggered these feelings.",
      "In the same period, how many days did you experience difficulty controlling or stopping your worrying thoughts? Briefly explain the circumstances or thoughts that led to this difficulty.",
      "Over the past two weeks, how frequently have you found yourself engaged in excessive worrying about various things? Please describe specific instances that led to this excessive worrying.",
      "How many days did you experience challenges in unwinding or relaxing? Briefly explain the circumstances or thoughts that made it difficult for you to relax",
      "Can you share any instances from the last two weeks where you felt restless or could not sit still? How frequently did this occur, and did it relate to any specific events or thoughts?",
      "How often, in the last 14 days, have you noticed an increased irritability in yourself? Can you identify any reasons or triggers behind this heightened irritability?",
      "Thinking about the last two weeks, how often have you experienced a sense of fear, as if something terrible might happen? Can you share any specific situations that triggered this feeling of fear",
    ],
    [
      // Depression questionnaire
      "How often have you felt a lack of interest or pleasure in activities over the past two weeks , and are there specific situations leading to this?",
      "On average, how frequently have you experienced feelings of sadness, depression, or hopelessness in the past two weeks? Additionally, is there a particular event or circumstance that stands out?",
      "Over the past two weeks, how many nights have you had trouble falling or staying asleep, or sleeping too much? Are there specific concerns affecting your sleep?",
      "How often have you felt tired or had little energy in the past two weeks? Can you identify any activities or situations influencing your energy levels?",
      "Have you noticed changes in your appetite or eating habits recently? Please share any specific situations or feelings related to these changes.",
      "How often have you experienced feelings of low self-worth or a sense of failure in the past two weeks? Are there any specific events leading to these feelings?",
      "On average, how many times a week have you had difficulty concentrating on tasks or activities? Are there certain circumstances influencing this difficulty?",
      "Have you observed changes in your pace of movement or speech in the past two weeks? If so, how often? Any specific situations influencing these changes?",
      "It's important to discuss difficult thoughts. Have you had thoughts of hurting yourself in the past two weeks, and if so, what seems to trigger these thoughts?",
    ],
    [
      // Alcohol use questionnaire
      "Describe the number of days per month when you typically consume alcohol. Include details about the situations or events that lead to your drinking.",
      "Specify the frequency with which you consume more than one standard drink on days when you decide to drink. Include details about the types of drinks and any patterns you've noticed.",
      "Describe the frequency of occasions in a month when you consume six or more drinks in one sitting. Include details about the reasons behind such occasions and any specific triggers.",
      "Explain the frequency with which you experience difficulty in stopping alcohol consumption once you've begun. Mention any factors or emotions that contribute to this challenge.",
      "This year , how often have you failed to fulfill your responsibilities because of drinking?",
      "This past year, how often do you feel the need to drink in the morning after a heavy drinking session?",
      "Elaborate on personal realizations or concerns that have led you to consider reducing your alcohol intake this year . Describe the motivations and challenges associated with this feeling.",
      "How frequently do you have difficulty remembering what happened the night before because of drinking?",
      "Specify the number of times this year where alcohol use has led to injuries, whether to yourself or others. Explain the circumstances and outcomes of these situations.",
      "Specify how often friends, family, or healthcare professionals have expressed worry about your alcohol consumption in a month. Include their perspectives and any actions they recommended.",
    ],
    [
      // Internet Addiction questionnaire
      "Have you noticed a pattern where you end up spending more time online than you initially planned? If so, how often does this happen?",
      "Do you ever let household chores slide for online activities? If yes, share how often ?",
      "Describe an instance where you find yourself choosing the excitement of the internet over spending quality time with your partner",
      "Could you please share your experience of forming new friendships with people you've met online?",
      "Have you encountered complaints from people in your life about the time you spend online?",
      "Describe any instances where your work may have been impacted due to excessive online activity, such as missing deadlines or postponing tasks?",
      "Do you prioritize checking your social media before important tasks? If so, could you describe your experience with this habit?",
      "Share your perspective on whether the time you invest online has led to any changes in your job performance or overall work productivity?",
      "When someone asks about your online activities, do you tend to get defensive or secretive?",
      "Describe your experience with using the internet as a way to avoid thinking about challenging aspects of your life.",
      "How eagerly do you await your next online session?",
      "What's your experience with the idea that life might be unexciting or lacking fulfillment without the internet?",
      "Can you share a personal experience or describe a situation where you felt upset when someone interrupted or bothered you while you were online?",
      "Could you share your experience of staying up late on the internet and the difficulties you encounter when trying to sleep afterwards?",
      "Have you ever caught yourself frequently pondering about being online, even when you're offline?",
      "Share your experience of intending to spend only a few more minutes online, but ultimately ending up spending a lot more time than you initially planned?",
      "Could you share an experience where your attempt to cut down on online time was unsuccessful?",
      "Could you describe whether you tend to keep your actual online usage time hidden from others?",
      "Could you please share your experience regarding whether you opt to use the internet rather than spending time with friends in person?",
      ". Can you share how being offline makes you feel and if those feelings change when you're back online?"
    ],
    [
      "Thank You for your response, you donot seem to be detected by any of our listed disrder. Still if you feel like sharing your feelings, you can have a conversation"
    ],
  ];

  @override
  void initState() {
    super.initState();
    responses =
        List.filled(questionnaires[predictedDisorderIndex()].length, "");
  }
@override
  Widget build(BuildContext context) {
    Color backgroundColor = predictedDisorderIndex() == 4
        ? Color.fromARGB(255, 157, 174, 245)
        : Color.fromARGB(255, 166, 147, 245);

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: backgroundColor,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: responses.where((response) => response.isNotEmpty).length /
                    questionnaires[predictedDisorderIndex()].length,
                color: Colors.blue, // Customize the progress bar color
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: questionnaires[predictedDisorderIndex()].length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          questionnaires[predictedDisorderIndex()].elementAt(index),
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16.0),
                        if (predictedDisorderIndex() != 4)
                          Container(
                            // Wrap TextField with Container and set the color
                            color: Colors.white,
                            child: TextField(
                              onChanged: (value) {
                                responses[index] = value;
                              },
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: "Type your response here...",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        SizedBox(height: 16.0),
                      ],
                    );
                  },
                ),
              ),
              if (predictedDisorderIndex() != 4)
                ElevatedButton(
                  onPressed: () {
                    saveResponsesAndNavigateToResult();
                  },
                  child: Text('Generate Report'),
                ),
              if (predictedDisorderIndex() == 4)
                ElevatedButton(
                  onPressed: () {
                    print("Chat with the chatbot");
                  },
                  child: Text('Chat with Chatbot'),
                ),
                ElevatedButton(
                onPressed: () {
                  extractAndPrintThemes(responses, widget.predictedDisorder);
                },
                child: Text('Print Themes'),
                ),
            ],
          ),
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   // Determine the background colors based on the detected disorder index
  //   Color backgroundColor = predictedDisorderIndex() == 4
  //       ? Color.fromARGB(255, 157, 174, 245)
  //       : Color.fromARGB(255, 74, 56, 148);

//     return Scaffold(
//       body: Container(
//         // Use the determined background color
//         color: Color.fromARGB(255, 157, 174, 245),
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Display all questions in a ListView
//             Expanded(
//               child: ListView.builder(
//                 itemCount: questionnaires[predictedDisorderIndex()].length,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         questionnaires[predictedDisorderIndex()]
//                             .elementAt(index),
//                         style: TextStyle(
//                             fontSize: 18.0, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 16.0),
//                       // Only show text response field if the detected index is not 4
//                       if (predictedDisorderIndex() != 4)
//                         TextField(
//                           onChanged: (value) {
//                             responses[index] = value;
//                           },
//                           maxLines: 5,
//                           decoration: InputDecoration(
//                             hintText: "Type your response here...",
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       SizedBox(height: 16.0),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             // Only show "Generate Report" button if the detected index is not 4
//             if (predictedDisorderIndex() != 4)

// //
//               ElevatedButton(
//                 onPressed: () {
//                   // Save responses and navigate to result page
//                   saveResponsesAndNavigateToResult();
//                 },
//                 child: Text('Generate Report'),
//               ),
//             // Show a button to chat with the chatbot if detected index is 4
//             if (predictedDisorderIndex() == 4)
//               ElevatedButton(
//                 onPressed: () {
//                   // Handle button press to chat with the chatbot
//                   // You can implement the chatbot integration here
//                   // For now, we'll just print a message to the console
//                   print("Chat with the chatbot");
//                 },
//                 child: Text('Chat with Chatbot'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

  int predictedDisorderIndex() {
    // Helper method to map predicted disorder to the corresponding index in questionnaires
    switch (widget.predictedDisorder) {
      case "Anxiety":
        return 0;
      case "Depression":
        return 1;
      case "Substance Abuse":
        return 2;
      case "Internet Addiction":
        return 3;
      case "No disorder detected":
        return 4;
      default:
        return 0;
    }
  }

  void saveResponsesAndNavigateToResult() async {
    User? user = _auth.currentUser;

    if (user != null) {
      CollectionReference userAssessments =
          _firestore.collection('userAssessments');
      DocumentReference userDocument = userAssessments.doc(user.uid);
      CollectionReference descriptiveResponsesCollection =
          userDocument.collection('descriptiveResponses');

      await descriptiveResponsesCollection.add({
        'timestamp': FieldValue.serverTimestamp(),
        'responses': responses,
        'predictedDisorder': widget.predictedDisorder,
      });
      // Save responses to storage or process them further
      // You can store responses in a database, file, or wherever you prefer
      // For now, we'll just print them to the console
      print("User responses: $responses");

      // // Initialize the sentiment variable here
      // final Sentiment sentiment = Sentiment.fromMap({});

      String descriptiveAnswers = responses.join('\n');
      final sentimentAnalysis = Sentiment.analysis(descriptiveAnswers);
      double sentimentScore = sentimentAnalysis.score / responses.length;

      String severity = getSeverityFromSentimentScore(sentimentScore);

      // Navigate to the result page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            predictedDisorder: widget.predictedDisorder,
            userResponses: responses,
            severityRating: severity,
            extractedThemes: extractedThemes,          )
            ,
        ),
      );
    }
  }

  String getSeverityFromSentimentScore(double sentimentScore) {
    if (sentimentScore < -0.5) {
      return 'High Severity';
    } else if (sentimentScore < 0) {
      return 'Medium Severity';
    } else {
      return 'Low Severity';
    }
  }
}
