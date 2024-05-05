import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome!'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Account'),
              onTap: () {
                // Navigate to account screen
              },
            ),
            ListTile(
              title: Text('Past Bookings'),
              onTap: () {
                // Navigate to past bookings screen
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'What do you need help with today?',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryPage()),
                );
              },
              child: Text('Select Category'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatbotPage()),
          );
        },
        child: Icon(Icons.help),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Category'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WorkerListPage(category: categories[index])),
              );
            },
          );
        },
      ),
    );
  }
}

class WorkerListPage extends StatelessWidget {
  final String category;

  WorkerListPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Workers - $category'),
      ),
      body: ListView.builder(
        itemCount: workers[category]!.length,
        itemBuilder: (context, index) {
          final worker = workers[category]![index];
          return ListTile(
            title: Text(worker['name']!),
            subtitle: Text(worker['rate']!),
            onTap: () {
              // Implement booking functionality
            },
          );
        },
      ),
    );
  }
}

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  bool isChatbotTyping = false;
  List<ChatMessage> _messages = [];

  Future<void> _getChatbotResponse(String query) async {
    try {
      setState(() {
        isChatbotTyping = true;
      });

      final response = await http.get(
        Uri.parse('https://gf4.404420.xyz/chatUser?text=${Uri.encodeComponent(query)}'),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final botResponse = responseBody['content'];

        final lines = botResponse.split('\n');
        final concatenatedMessage = lines.join('\n');

        ChatMessage message = ChatMessage(
          text: concatenatedMessage,
          isUserMessage: false,
        );

        setState(() {
          _messages.insert(0, message);
          isChatbotTyping = false;
        });
      } else {
        print('API Error: ${response.reasonPhrase}');
        setState(() {
          isChatbotTyping = false;
        });
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        isChatbotTyping = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message.text),
                  subtitle: Text(message.isUserMessage ? 'You' : 'Chatbot'),
                );
              },
            ),
          ),
          isChatbotTyping ? CircularProgressIndicator() : Container(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: (value) {
                _getChatbotResponse(value);
              },
              decoration: InputDecoration(
                labelText: 'Type your message...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _getChatbotResponse('User: ${_messages.last.text}');
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUserMessage;

  ChatMessage({required this.text, required this.isUserMessage});
}

List<String> categories = ['Plumbing', 'Electrical', 'Cleaning', 'Carpentry'];

Map<String, List<Map<String, String>>> workers = {
  'Plumbing': [
    {'name': 'John', 'rate': '₹200/hour'},
    {'name': 'Alice', 'rate': '₹250/hour'},
  ],
  'Electrical': [
    {'name': 'Mike', 'rate': '₹180/hour'},
    {'name': 'Emily', 'rate': '₹220/hour'},
  ],
  'Cleaning': [
    {'name': 'David', 'rate': '₹150/hour'},
    {'name': 'Sarah', 'rate': '₹180/hour'},
  ],
  'Carpentry': [
    {'name': 'James', 'rate': '₹220/hour'},
    {'name': 'Olivia', 'rate': '₹200/hour'},
  ],
};