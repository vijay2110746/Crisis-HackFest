import 'package:flutter/material.dart';
import 'message_card.dart';

class MessageCategory {
  final String category;
  final List<Message> messages;

  MessageCategory({required this.category, required this.messages});
}

class CategoryWidget extends StatelessWidget {
  final MessageCategory category;
  final Function(Message) onMessageTap;

  const CategoryWidget({Key? key, required this.category, required this.onMessageTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.category,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ...category.messages.map((message) {
          return MessageCard(
            message: message,
            onTap: onMessageTap,
            categoryMessages: category.messages,
          );
        }).toList(),
        SizedBox(height: 20),
      ],
    );
  }
}

class Message {
  String sender;
  String content;
  int unreadCount;

  Message({required this.sender, required this.content, required this.unreadCount});
}
