import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(DepressionPage());
}

class DepressionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.transparent,
        accentColor: const Color.fromARGB(255, 0, 0, 0),
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> videoUrls = [
    'https://www.youtube.com/watch?v=Sxddnugwu-8',
    'https://www.youtube.com/watch?v=KwJp1q6nFdA',
    'https://youtu.be/Sxddnugwu-8?feature=shared',
    'https://www.youtube.com/watch?v=RV5MEP3Bgkc',
    'https://www.youtube.com/watch?v=KD0rrJwIJas',
  ];

  late List<YoutubePlayerController> _controllers;

 @override
  void initState() {
    super.initState();
    _controllers = videoUrls.map((url) {
      return YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    }).toList();
  }

  // @override
  // void dispose() {
  //   for (var controller in _controllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          borderRadius: BorderRadius.circular(0.0),
          border: Border.all(color: Color.fromARGB(255, 74, 56, 148)),
        ),
        padding: EdgeInsets.all(26.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubsectionTitle('What is Depression?'),
              _buildParagraph(
                  'Depression is when you feel really, really down for a long time, and it messes with everything—your mood, energy, and interest in stuff. Its not just a passing sadness; it sticks around. But the good news is, there are ways to tackle it with help.'),
              _buildSubsectionTitle('Why Does it Happen?'),
              _buildParagraph(
                  'Depression can be caused by a mix of factors, including changes in brain chemistry, genetic predisposition, life events like trauma or stress, and even certain health conditions. It\'s often a combination of these elements that contributes to the development of depression in individuals'),
              _buildSubsectionTitle('Types of Depression'),
              _buildBulletPoint('Major Depressive Disorder (MDD): Characterized by severe symptoms that interfere with daily life.'),
              _buildBulletPoint('Persistent Depressive Disorder (Dysthymia): Long-term, chronic depression with milder symptoms'),
              _buildBulletPoint('Bipolar Disorder: Involves alternating periods of depression and mania.'),
              _buildBulletPoint('Seasonal Affective Disorder (SAD): Depression that occurs seasonally, often in the winter'),
              _buildBulletPoint('Postpartum Depression: Affecting new mothers, it involves persistent sadness after childbirth'),
              _buildSubsectionTitle('Symptoms of Depression'),
              _buildBulletPoint('Persistent Sadness :- Feeling down or hopeless for most of the day, nearly every day.'),
              _buildBulletPoint('Loss of Interest:- Losing interest or pleasure in activities once enjoyed'),
              _buildBulletPoint('Change in Sleep:- Insomnia or excessive sleeping'),
              _buildBulletPoint('Changes in Appetite:- Significant weight loss or gain'),
              _buildBulletPoint('Fatigue:- Feeling tired and lacking energy'),
              _buildSubsectionTitle('How to Manage Depression?'),
              _buildParagraph('Talk to someone you trust, set small daily goals, and consider therapy or medication with guidance from a healthcare professional to help manage depression.'),
              _buildSubsectionTitle('Useful resources'),
              _buildYoutubePlayers(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }

  Widget _buildSubsectionTitle(String title) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 74, 56, 148),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 8.0),
          Text(
            title,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Color.fromARGB(255, 74, 56, 148)),
        color: Colors.white, // Set the background color to white
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Color.fromARGB(255, 74, 56, 148)),
        color: Colors.white, // Set the background color to white
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.arrow_forward, color: Colors.blueAccent),
          SizedBox(width: 8.0),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 8.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLink(String title, String url) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () async {
          if (await canLaunch(url)) {
            await launch(url, forceSafariVC: false, forceWebView: false);
          } else {
            throw 'Could not launch $url';
          }
        },
        child: Text(
          title,
          style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
              fontSize: 16.0),
        ),
      ),
    );
  }
   Widget _buildYoutubePlayers() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          videoUrls.length,
          (index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YoutubePlayer(
                controller: _controllers[index],
                showVideoProgressIndicator: true,
                onReady: () {
                  // Optional: Pause the video initially
                  _controllers[index].pause();
                },
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  _toggleVideoPlayPause(index);
                },
                child: Container(
                  color: Colors.transparent, // Make the video area tappable
                  child: Center(
                    child: Icon(
                      _controllers[index].value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 64.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }


  void _launchUrl(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false, forceWebView: false);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

    void _toggleVideoPlayPause(int index) {
    final controller = _controllers[index];
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
  }
}
