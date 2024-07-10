import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'message_category.dart';

class MessageDetailPage extends StatefulWidget {
  final Message message;
  final List<Message> categoryMessages;

  const MessageDetailPage({Key? key, required this.message, required this.categoryMessages}) : super(key: key);

  @override
  _MessageDetailPageState createState() => _MessageDetailPageState();
}

class _MessageDetailPageState extends State<MessageDetailPage> {
  List<Message> messages = [];
  TextEditingController _controller = TextEditingController();
  String? volunteerId;
  String? victimId;

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('Got the victim ID');
      victimId = user.uid;
      _fetchVolunteerIdAndMessages();
    } else {
      print("Didn't get the victim ID");
    }
  }

  void _fetchVolunteerIdAndMessages() async {
    // Fetch the volunteerId from the victims collection using the victimId
    DocumentSnapshot<Map<String, dynamic>> victimDoc = await FirebaseFirestore.instance
        .collection('victims')
        .doc(victimId) // Assuming sender is the victimId
        .get();

    if (victimDoc.exists) {
      volunteerId = victimDoc.data()?['volunteerId'];
      if (volunteerId != null) {
        // Listen for real-time updates
        FirebaseFirestore.instance
            .collection('chats')
            .doc(volunteerId)
            .snapshots()
            .listen((documentSnapshot) {
          if (documentSnapshot.exists) {
            final data = documentSnapshot.data();
            if (data != null && data.containsKey('messages')) {
              setState(() {
                messages = (data['messages'] as List<dynamic>).map((messageData) {
                  return Message(
                    sender: messageData['sender'],
                    content: messageData['content'],
                    unreadCount: 0,
                  );
                }).toList();
              });
            }
          }
        });
      }
    }
  }

  void _sendMessage() async {
    final content = _controller.text;
    if (content.isNotEmpty && volunteerId != null) {
      final message = Message(
        sender: 'Victim',
        content: content,
        unreadCount: 0,
      );

      setState(() {
        messages.add(message);
        _controller.clear();
      });

      // Add the new message to Firestore
      final messageData = {
        'sender': message.sender,
        'content': message.content,
        'timestamp': Timestamp.now(), // Use Timestamp.now() instead
      };

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(volunteerId)
          .update({
        'messages': FieldValue.arrayUnion([messageData]),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Volunteer'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message.sender == 'Victim' ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: message.sender == 'Victim' ? Colors.green[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(message.content),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
