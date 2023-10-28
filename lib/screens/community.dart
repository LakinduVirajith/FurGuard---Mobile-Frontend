import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Message {
  final String sender;
  final String content;

  Message({required this.sender, required this.content});
}


class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          'Community',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: LostPetNoticesList(), // Use your custom LostPetNoticesList widget
      ),
    );
  }
}
@override
Widget build(BuildContext context) {
  List<Message> messages = [
    Message(sender: 'Alice', content: 'Hello!'),
    Message(sender: 'Bob', content: 'Hi there!'),
    Message(sender: 'Alice', content: 'How are you?'),
    // Add more messages as needed
  ];

  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/pet_profile_bg.png'), // Replace with your image asset
        fit: BoxFit.cover,
      ),
    ),
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Group Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                Message message = messages[index];
                return ListTile(
                  title: Text('${message.sender}: ${message.content}'),
                );
              },
            ),
          ),
          _buildMessageInputField(),
        ],
      ),
    ),
  );
}
Widget _buildMessageInputField() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Type a message...',
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            // Implement sending message functionality
          },
        ),
      ],
    ),
  );
}

class LostPetNoticesList extends StatefulWidget {
  @override
  _LostPetNoticesListState createState() => _LostPetNoticesListState();
}

class _LostPetNoticesListState extends State<LostPetNoticesList> {
  List<String> notices = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get('http://localhost:8080/profile/notice' as Uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Assuming the API returns a list of lost pet notices as strings
      if (data is List) {
        setState(() {
          notices = List<String>.from(data);
        });
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notices.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(notices[index]),
          ),
        );
      },
    );
  }
}
