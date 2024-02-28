import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

const TextStyle poppinsTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 18.0,
  fontWeight: FontWeight.normal,
);

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saarthi Chatbot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyMedium: poppinsTextStyle,
        ),
      ),
      home: SafeArea(
        child: Container(
          color:
              Color.fromARGB(255, 0, 0, 0), // Set your desired background color
          child: ChatScreen(),
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  List<ChatMessage> _messages = [];
  String openaiApiKey =
      "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"; // Replace with your actual API key

  @override
  void initState() {
    super.initState();
    // Add the chatbot's initial message when the page opens
    _initializeChat();
  }

  void _initializeChat() async {
    String initialGreeting = _getGreeting();
    String chatbotReply = await getChatbotReply(
        "Hey, $initialGreeting, how can I help you today?");

    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          text: chatbotReply,
          name: 'Saarthi',
          sentTime: DateTime.now(),
        ),
      );
    });
  }

  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saarthi'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            color: Color.fromARGB(255, 120, 156, 228),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    onSubmitted: _handleSubmitted,
                    onChanged: (text) {
                      // Handle text changes if needed
                    },
                    decoration: InputDecoration.collapsed(
                      hintText: 'Type a message',
                      hintStyle: poppinsTextStyle,
                    ),
                    style: poppinsTextStyle,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _handleSubmitted(_controller.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) async {
    if (text.isNotEmpty) {
      _controller.clear();

      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            text: text,
            name: 'User',
            isUser: true,
            sentTime: DateTime.now(),
          ),
        );
      });

      String chatbotReply = await getChatbotReply(text);

      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            text: chatbotReply,
            name: 'Saarthi',
            sentTime: DateTime.now(),
          ),
        );
      });

      _focusNode.unfocus();
    }
  }

  Future<String> getChatbotReply(String userMessage) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $openaiApiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'system',
            'content':
                'Imagine you are from India, so reply in a cultured way.Your role is to act as someone dedicated to providing friendly support and listening to individuals navigating through discomfort and loneliness .The person might be facing issues like Anxiety , Depression, Internet Addiction, and Drug Abuse. The support is not only limtied to these conditions , but also extends to other problems faced by the individuals which include mental and physical conditions that the individuals might be going through .Your role is to act and talk as a friend and dont mention that you are an AI model. Do not greet the user after every message and dont irritate them. But there is a condition to your role, While not a substitute for professional help, you encourage users to consider seeking assistance from mental health professionals for a comprehensive and personalized approach . You just have to talk like a friend , you have no authority whatsoever to provide professional advice or prescription to the participant at any cost . You offer a safe space for individuals to express their true feelings. The characteristics mentioned below are a part of your personality and identity as a chatbot  : Expressing emotions in your replies, Using positive reinforcement to uplife the users mood, Acknowledging the users emotions and validate their feelings, Encouraging users to share more about their feelings by asking open-ended questions, Avoiding responses that come across as negative and insensitive. Remember , Your unique ability to remember and reference past conversations allows for a more personalized interaction, fostering a continuous and supportive relationship as users navigate their mental health journey. Keep your replies as short,sweet,emotionally backing & crisp as possible and try to limit in 3-4 sentences. Remember to maintain the context of conversation and reply by keeping the previous responses in mind. Keep the replies as short as possible'
          },
          {'role': 'user', 'content': userMessage},
        ],
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['choices'][0]['message']['content'];
    } else {
      print('API Error: ${response.statusCode}, ${response.body}');
      throw Exception('Failed to get chatbot response');
    }
  }
}

class ChatMessage extends StatelessWidget {
  final String name;
  final String text;
  final bool isUser;
  final DateTime sentTime;

  ChatMessage({
    required this.name,
    required this.text,
    this.isUser = false,
    required this.sentTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) CircleAvatar(child: Text(name[0])),
          if (!isUser) SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: isUser
                  ? CrossAxisAlignment.end // Align user's messages to the right
                  : CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isUser) SizedBox(width: 8.0),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 35, 69, 99), // Custom color
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: isUser
                        ? Color.fromARGB(255, 28, 70, 90)
                        : Colors.grey[200], // Custom colors
                    borderRadius: isUser
                        ? BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          )
                        : BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          ),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: isUser
                              ? Color.fromARGB(255, 255, 255, 255)
                              : Colors.black, // Custom colors
                        ),
                        overflow: TextOverflow.visible,
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        DateFormat('h:mm a').format(sentTime),
                        style: TextStyle(
                          fontSize: 10.0,
                          color: isUser ? Colors.white : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.0),
          if (isUser) CircleAvatar(child: Text(name[0])),
        ],
      ),
    );
  }
}
