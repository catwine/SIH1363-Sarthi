import 'package:flutter/material.dart';
import 'package:saarthi/pages/get_started_page.dart';
import 'package:saarthi/pages/informative_page.dart';
import 'descriptive_test.dart';
import 'psychologist_details_page.dart';
import 'chatbot.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui' as ui;
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// import 'package:open_file/open_file.dart';

class ResultPage extends StatelessWidget {
  final String predictedDisorder;
  final List<String> userResponses;
  final String severityRating;
  final List<String> removedThemes; // Add removedThemes parameter
  final List<String> extractedThemes; // Add this line
//   Future<void> generateAndSavePDF() async {
//   final pdf = pw.Document();

//   pdf.addPage(pw.Page(
//     build: (pw.Context context) {
//       return pw.Column(
//         crossAxisAlignment: pw.CrossAxisAlignment.start,
//         children: [
//           pw.Text("Patient Mental Health Report", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//           pw.SizedBox(height: 10),
//           // Add other information from your report card here

//           // Example: Age and Gender
//           pw.Row(
//             children: [
//               pw.Text("Age: ", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//               pw.Text("User's Age"),
//               pw.SizedBox(width: 20),
//               pw.Text("Gender: ", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//               pw.Text("User's Gender"),
//             ],
//           ),

//           // Add more content as needed
//         ],
//       );
//     },
//   ));

//    final file = await saveDocument(pdf);
// }

//     Future<File> saveDocument(pw.Document pdf) async {
//     final bytes = await pdf.save();
//     final file = File('mental_health_report.pdf');
//     await file.writeAsBytes(bytes);
//     return file;
//   }

  //  String getProbableReason() {
  //   switch (predictedDisorder) {
  //     case 'Anxiety':
  //       // Implement logic to analyze user responses for anxiety
  //       return "Possible reasons for anxiety based on your responses...";
  //     case 'Depression':
  //       // Implement logic to analyze user responses for depression
  //       return "Possible reasons for depression based on your responses...";
  //     case 'Substance Abuse':
  //       // Implement logic to analyze user responses for substance abuse
  //       return "Possible reasons for substance abuse based on your responses...";
  //     case 'Internet Addiction':
  //       // Implement logic to analyze user responses for internet addiction
  //       return "Possible reasons for internet addiction based on your responses...";
  //     case 'No disorder detected':
  //       return "No specific disorder detected. Continue monitoring your mental health.";
  //     default:
  //       return "";
  //   }
  // }

  ResultPage({
    required this.predictedDisorder,
    required this.userResponses,
    required this.severityRating,
    required this.extractedThemes, // Add this line

    List<String>? removedThemes, // Add a "?" to make it nullable
  }) : this.removedThemes = removedThemes ??
            []; // Use null-aware operator to provide a default value

  get di_rating => severityRating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 157, 174, 245),
                  Color.fromARGB(255, 157, 174, 245)
                ],
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Thank you so much for your responses! Your results are as follows, based on your inputs.",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 30, 17, 81)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10.0),
                    const Divider(
                        thickness: 2.0,
                        color: Color.fromARGB(255, 74, 56, 148)),
                    const SizedBox(height: 10.0),

                    //Report Card

                    Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.asset(
                              'assets/saarthilogo.png',
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.contain,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Your Mental Health Report",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 74, 56, 148),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            const Divider(thickness: 2.0),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Age: ",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 74, 56, 148),
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20.0),
                                Expanded(
                                  child: Text(
                                    "Gender: ",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 74, 56, 148),
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            const SizedBox(height: 10.0),
                            const SizedBox(height: 10.0),
                            const SizedBox(height: 10.0),
                            Text(
                              "Detected Disorder :    $predictedDisorder",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(height: 10.0),

                            const SizedBox(height: 10.0),
                            const SizedBox(height: 10.0),

                            Text(
                              "Severity Rating :      $severityRating ",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(height: 10.0),

                            const SizedBox(height: 10.0),
                            const SizedBox(height: 10.0),
                            const Text(
                              "Probable Reason : ",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(height: 20.0),
                            // Display extracted themes
                            if (extractedThemes.isNotEmpty)
                              Text(
                                extractedThemes.toSet().toList().join(', '),
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),

                            const SizedBox(height: 20.0),
                            const Divider(thickness: 2.0),
                            Text(
                              "Please note: The above results are solely based on the responses which you gave. Do not consider this report as a diagnosis whereas consider seeking help from Mental health professionals. We advise you to get in touch with nearby healthcare professionals. You can check your nearby professionals through our app. ",
                              style: TextStyle(
                                  fontSize: 08.0,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 5.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            shareReport();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Share Report',
                            style: TextStyle(
                              color: Color.fromARGB(255, 74, 56, 148),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await generateAndSaveRawCard(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Download Report',
                            style: TextStyle(
                              color: Color.fromARGB(255, 74, 56, 148),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Display personalized guidance based on severity
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 4.0),
                    //   child: Text(
                    //     getGuidanceCard(),
                    //     style: TextStyle(
                    //       fontSize: 16.0,
                    //       color: Color.fromARGB(255, 30, 17, 81), // White text color
                    //       fontWeight: FontWeight.bold, // Bold text
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),

                    Card(
                      color: Colors.white,
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          getGuidanceCard(),
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color.fromARGB(255, 30, 17, 81),
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InformativePage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Know More!',
                            style: TextStyle(
                                color: Color.fromARGB(255, 74, 56, 148)),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Let\'s Chat',
                            style: TextStyle(
                                color: Color.fromARGB(255, 74, 56, 148)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyRecommendationPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                      ),
                      child: const Text(
                        'Find Best Doc!',
                        style:
                            TextStyle(color: Color.fromARGB(255, 74, 56, 148)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DescriptiveTestPage(
                              predictedDisorder: predictedDisorder,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                      ),
                      child: const Text(
                        'Go Back',
                        style: TextStyle(
                          color: Color.fromARGB(255, 74, 56, 148),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void shareReport() {
    String reportText = """
    
    
  *Mental Health Report*

  Below are the probable results from *Saarthi* 
  Donot consider this as your final scores, consider seeking guidance from Mental health professionals.

  Age: User's Age

  Gender: User's Gender

  Detected Disorder: $predictedDisorder

  Severity Rating: $severityRating

    

*Please note:* _The above results are solely based on the responses you gave. Do not consider this report as a diagnosis, and seek help from Mental health professionals. We advise you to get in touch with nearby healthcare professionals. You can check your nearby professionals through our app._
  """;

    Share.share(reportText, subject: 'Mental Health Report');
  }

  Future<void> generateAndSaveRawCard(BuildContext context) async {
    final rawCardContent = """
  *Mental Health Report*

  Detected Disorder: $predictedDisorder

  Severity Rating: $severityRating

  *Please note:* _The above results are solely based on the responses you gave. Do not consider this report as a diagnosis, and seek help from Mental health professionals. We advise you to get in touch with nearby healthcare professionals. You can check your nearby professionals through our app._
  """;

    saveRawCard(rawCardContent).then((file) {
      // Notify the user or perform any UI update as needed
      // For example, show a snackbar or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Raw card downloaded successfully!'),
        ),
      );
    });
  }

  Future<File> saveRawCard(String rawCardContent) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/mental_health_raw_card.txt');
    await file.writeAsString(rawCardContent);
    return file;
  }

  String getGuidanceCard() {
    switch (severityRating) {
      case 'Low Severity':
        return """

As you are dealing with low-severity
We have a quick tips for you!

- Acknowledge Your Feelings
- Talk to Someone
- Establish Routine
- Mindfulness & Relaxation
- Create Healthy Lifestyle
- Set Realistic Goals
- Limit Stressors
- Engage in Hobbies

If issues persist, consult a healthcare professional for personalized support. You're not alone.
        
         """;
      case 'Medium Severity':
        return """
As you are dealing with moderate-severity
We have a quick tips for you!

Acknowledge Your Struggles
Open Up to Someone
Establish Structured Routine
Seek Professional Guidance
Prioritize Self-Care
Set Realistic Goals
Engage in Therapy

Reach out for help—there's support available.
      """;
      case 'High Severity':
        return """
As you are dealing with high-severity
We have a quick tips for you!

Seek Immediate Support
Avoid Isolation
Prioritize Safety
Follow Professional Advice

You're not alone—help is available. Prioritize your well-being

      """;
      default:
        return "";
    }
  }
}
