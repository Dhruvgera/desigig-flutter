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
      body: ListView.separated(
        padding: EdgeInsets.all(16.0),
        itemCount: categories.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.category),
            title: Text(
              categories[index],
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      WorkerListPage(category: categories[index]),
                ),
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
        Uri.parse(
            'https://gf4.404420.xyz/chatUser?text=${Uri.encodeComponent(query)}'),
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

List<String> categories = [
  'Plumbing',
  'Electrical',
  'Cleaning',
  'Carpentry',
  'Cooking',
  'Painting',
  'Gardening',
  'Baby Sitting',
  'Laundry',
  'Dog Walking',
  'House Sitting',
  'Window Cleaning',
  'Personal Assistant',
  'Event Planning',
  'Home Organization',
  'Furniture Assembly',
  'Appliance Repair',
  'Computer Repair',
  'Tutoring',
  'Photography',
  'Fitness Training',
  'Massage Therapy',
  'Yard Work',
  'Handyman Services',
  'Pool Cleaning',
  'Car Washing',
  'Home Security Installation',
  'Pet Grooming',
  'Interior Design',
  'Carpet Cleaning',
  'Junk Removal',
  'Home Inspections',
  'Landscaping',
  'Moving Services',
  'Pet Training',
  'Home Renovation',
  'Roof Repair',
  'Deck Building',
  'Concrete Work',
  'Fencing',
  'Drywall Repair',
  'Pest Control',
  'Tree Trimming',
  'Plastering',
  'Locksmith',
  'Flooring',
  'Hvac Repair',
  'Septic Tank Services',
  'House Painting',
  'Siding Installation',
  'Exterior Painting',
  'Cabinet Installation',
  'Countertop Installation',
  'Kitchen Remodeling',
  'Bathroom Remodeling',
  'Basement Finishing',
  'Sunroom Construction',
  'Deck Repair',
  'Patio Construction',
  'Garage Door Repair',
  'Furniture Repair',
  'Water Heater Repair',
  'Fireplace Installation',
  'AC Installation',
  'Heating Installation',
  'Smart Home Installation',
  'Home Theater Installation',
  'Generator Installation',
  'Solar Panel Installation',
  'Mold Removal',
  'Water Damage Restoration',
  'Flood Cleanup',
  'Radon Mitigation',
  'Asbestos Removal',
  'Lead Paint Removal',
  'Insulation Installation',
  'Sump Pump Installation',
  'Roof Cleaning',
  'Window Installation',
  'Door Installation',
  'Storm Door Installation',
  'Fencing Installation',
  'Gate Installation',
  'Pool Repair',
  'Deck Staining',
  'Stucco Repair',
  'Exterior Trim Repair',
  'Soffit Repair',
  'Fascia Repair',
  'Garage Organization',
  'Attic Insulation',
  'Shelving Installation',
  'Closet Organization',
  'Bedroom Remodeling',
  'Living Room Remodeling',
  'Dining Room Remodeling',
  'Home Additions',
  'Home Extensions',
  'Custom Home Building',
  'Modular Home Construction',
  'Prefab Home Construction',
  'Tiny House Construction',
  'Mobile Home Repair',
  'Mobile Home Remodeling',
  'Mobile Home Skirting',
  'Roof Replacement',
  'Siding Repair',
  'Foundation Repair',
  'Brickwork',
  'Masonry',
  'Concrete Pouring',
  'Patio Repair',
  'Retaining Wall Construction',
  'Outdoor Kitchen Construction',
  'Outdoor Fireplace Construction',
  'Landscape Lighting Installation',
  'Tree Removal',
  'Stump Removal'
];

Map<String, List<Map<String, String>>> workers = {
  'Plumbing': [
    {'name': 'John', 'rate': '₹200/hour'},
    {'name': 'Alice', 'rate': '₹250/hour'},
    {'name': 'Robert', 'rate': '₹230/hour'},
    {'name': 'Jessica', 'rate': '₹210/hour'},
    {'name': 'Michael', 'rate': '₹220/hour'},
    {'name': 'Jennifer', 'rate': '₹240/hour'},
  ],
  'Electrical': [
    {'name': 'Mike', 'rate': '₹180/hour'},
    {'name': 'Emily', 'rate': '₹220/hour'},
    {'name': 'Daniel', 'rate': '₹200/hour'},
    {'name': 'Sophia', 'rate': '₹210/hour'},
    {'name': 'Matthew', 'rate': '₹190/hour'},
    {'name': 'Ava', 'rate': '₹230/hour'},
  ],
  'Cleaning': [
    {'name': 'David', 'rate': '₹150/hour'},
    {'name': 'Sarah', 'rate': '₹180/hour'},
    {'name': 'Christopher', 'rate': '₹160/hour'},
    {'name': 'Emma', 'rate': '₹170/hour'},
    {'name': 'Andrew', 'rate': '₹190/hour'},
    {'name': 'Olivia', 'rate': '₹200/hour'},
  ],
  'Carpentry': [
    {'name': 'James', 'rate': '₹220/hour'},
    {'name': 'Olivia', 'rate': '₹200/hour'},
    {'name': 'Liam', 'rate': '₹230/hour'},
    {'name': 'Isabella', 'rate': '₹210/hour'},
    {'name': 'Benjamin', 'rate': '₹240/hour'},
    {'name': 'Sophia', 'rate': '₹220/hour'},
  ],
  'Cooking': [
    {'name': 'Maria', 'rate': '₹300/hour'},
    {'name': 'Daniel', 'rate': '₹280/hour'},
    {'name': 'Sophia', 'rate': '₹320/hour'},
    {'name': 'Matthew', 'rate': '₹290/hour'},
    {'name': 'Emily', 'rate': '₹310/hour'},
    {'name': 'David', 'rate': '₹330/hour'},
  ],
  'Painting': [
    {'name': 'Sophia', 'rate': '₹200/hour'},
    {'name': 'Michael', 'rate': '₹250/hour'},
    {'name': 'Isabella', 'rate': '₹220/hour'},
    {'name': 'Ethan', 'rate': '₹240/hour'},
    {'name': 'Emma', 'rate': '₹210/hour'},
    {'name': 'Alexander', 'rate': '₹230/hour'},
  ],
  // Add more workers for other categories here...
};
