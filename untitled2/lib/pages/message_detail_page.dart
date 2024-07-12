import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
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
  String? userId;
  File? imageFile;

  @override
  void initState() {
    super.initState();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print("Got the volunteer ID");
      userId = user.uid;
      _fetchMessages();
    } else {
      print('Invalid volunteer ID');
    }
  }

  void _fetchMessages() async {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(userId)
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
                type: messageData['type'], // assuming you have a 'type' field to differentiate text and image messages
              );
            }).toList();
          });
        }
      }
    });
  }

  void _sendImage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    try {
      String fileName = Uuid().v1();
      var ref = FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");
      var uploadTask = await ref.putFile(imageFile!);
      String imageUrl = await uploadTask.ref.getDownloadURL();
      _sendImageMessage(imageUrl: imageUrl);
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  void _sendImageMessage({required String imageUrl}) async {
    final message = Message(
      sender: 'Volunteer',
      content: imageUrl,
      unreadCount: 0,
      type: 'image',
    );

    setState(() {
      messages.add(message);
    });

    final messageData = {
      'sender': 'Volunteer',
      'content': imageUrl,
      'timestamp': Timestamp.now(),
      'type': 'image',
    };

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(userId)
        .update({
      'messages': FieldValue.arrayUnion([messageData]),
    });
  }

  void _sendTextMessage() async {
    final content = _controller.text;

    if (content.isNotEmpty) {
      final message = Message(
        sender: 'Volunteer',
        content: content,
        unreadCount: 0,
        type: 'text',
      );

      setState(() {
        messages.add(message);
        _controller.clear();
      });

      final messageData = {
        'sender': 'Volunteer',
        'content': content,
        'timestamp': Timestamp.now(),
        'type': 'text',
      };

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(userId)
          .update({
        'messages': FieldValue.arrayUnion([messageData]),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Victim'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message.sender == 'Volunteer'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.all(10),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color: message.sender == 'Volunteer' ? Colors.blue[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: message.type == 'image'
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(message.content, fit: BoxFit.cover),
                    )
                        : Text(message.content),
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
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.image),
                      onPressed: _sendImage,
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _sendTextMessage,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
