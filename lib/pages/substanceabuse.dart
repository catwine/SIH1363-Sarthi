import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(SubstanceAbuse());
}

class SubstanceAbuse extends StatelessWidget {
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
    'https://www.youtube.com/watch?v=QtFzJt9nyLQ',
    'https://www.youtube.com/watch?v=StM10jzbt1k',
    'https://www.youtube.com/watch?v=8P7kd5AtZrk',
    'https://www.youtube.com/watch?v=6E8XGyLnASQ',
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
              _buildSubsectionTitle('What is Substance Abuse?'),
              _buildParagraph(
                  'Substance abuse refers to the risky or excessive use of drugs or alcohol, which can result in addiction and problems with one\'s physical or mental well-being. It is characterized by continuous use in spite of difficulties.'),
              _buildSubsectionTitle('Why Does it Happen?'),
              _buildParagraph(
                  'Genetic traits can have an impact on substance usage; certain people may be born with an increased risk of addiction. Peer pressure and exposure to substance usage are examples of environmental factors considered significant. Substance misuse is more likely to occur when people resort to substances as a coping technique as a result of stress, trauma, and difficulty handling emotional concerns.'),
              _buildSubsectionTitle('Types of Substance Abuse'),
              _buildBulletPoint('Alcohol Abuse'),
              _buildBulletPoint('Drug Abuse (e.g., opioids, cocaine)'),
              _buildBulletPoint('Prescription Drug Misuse'),
              _buildSubsectionTitle('Symptoms of Substance Abuse'),
              _buildBulletPoint(
                  'Physical: shaking hands, changes in appetite, and dark circles under the eyes.'),
              _buildBulletPoint(
                  'Behavioral: Mood swings, disregard for expectations.'),
              _buildBulletPoint(
                  'Psychological: Depression, anxiety, and mistrust.'),
              _buildBulletPoint(
                  'Social: Tight relationships, difficulties at work and in school.'),
              _buildSubsectionTitle('How to Cure Substance Abuse?'),
              _buildParagraph(
                  'Natural Approaches for Treatment: Therapy (counseling, support groups, and behavioral therapies), Lifestyle Changes (exercise, healthy nutrition, stress reduction techniques like meditation or yoga).'),
              _buildSubsectionTitle('Useful Resources'),
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
