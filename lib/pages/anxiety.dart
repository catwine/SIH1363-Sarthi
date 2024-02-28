import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(AnxietyPage());
}

class AnxietyPage extends StatelessWidget {
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
    'https://youtu.be/w_2STJAJhJM?feature=shared',
    'https://youtu.be/eAK14VoY7C0?feature=shared',
    'https://youtu.be/hJbRpHZr_d0?feature=shared',
    'https://youtu.be/4pLUleLdwY4?feature=shared',
    'https://youtu.be/Pvh0JIqSz7g?feature=shared',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                _buildSubsectionTitle('What is Anxiety?'),
                _buildParagraph(
                    'Anxiety is a natural response to stress, causing feelings of unease or worry It often comes with physical symptoms like a fast heartbeat or tense muscles When it becomes overwhelming, it might be worth seeking support'),
                _buildSubsectionTitle('Why Does it Happen?'),
                _buildParagraph(
                    'Anxiety is like your brain\'s way of sounding an alarm when it thinks something stressful is happening.It can be set off too easily based on your genes, how your brain works, and what you\'ve been through in life.'),
                _buildSubsectionTitle('Types of Anxiety'),
                _buildBulletPoint('Generalized Anxiety Disorder'),
                _buildBulletPoint('Social Anxiety Disorder'),
                _buildBulletPoint('Panic Disorder'),
                _buildBulletPoint('Obsessive-Compulsive Disorder'),
                _buildBulletPoint('Post Traumatic Stress Disorder'),
                _buildSubsectionTitle('Symptoms of Anxiety'),
                _buildBulletPoint(
                    'Physical :- Rapid heartbeat, sweating, trembling, fatigue, muscle tension.'),
                _buildBulletPoint(
                    'Emotional:-Restlessness, irritability, feeling on edge, difficulty concentrating.'),
                _buildBulletPoint(
                    'Cognitive:- Excessive worry, racing thoughts, trouble making decisions.'),
                _buildBulletPoint(
                    'Behavioral:- Avoidance of situations that trigger anxiety, compulsive behaviors.'),
                _buildBulletPoint(
                    'Sleep:-Difficulty falling asleep, staying asleep, or restless sleep.'),
                _buildSubsectionTitle('How to Manage Anxiety?'),
                _buildParagraph(
                    'To manage anxiety, try talking to a therapist—they\'re like anxiety coaches. '
                    'Sometimes, doctors might recommend medications to help. Also, doing stuff like exercising, sleeping well, and taking time to chill can really make a difference.'),
                _buildSubsectionTitle('Useful resources'),
                _buildYoutubePlayers(),
              ],
            ),
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
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blue),
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
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Color.fromARGB(255, 74, 56, 148)),
        color: Colors.white, // Set the background color to white
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.arrow_forward, color: Color.fromARGB(255, 74, 56, 148)),
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
