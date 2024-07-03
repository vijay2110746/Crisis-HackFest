import 'package:flutter/material.dart';
import 'package:untitled2/components/top_navbar.dart';
import 'message_category.dart';
import 'message_card.dart';
// import 'package:untitled2/components/bottom_navbar.dart';

class InboxPage extends StatefulWidget {
  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  List<Message> waterCanMessages = [
    Message(sender: 'Aavesh Krishnan', content: 'Bro 3 water cans available...', unreadCount: 4),
    Message(sender: 'Micheal Alagar', content: 'Watercan available contact...', unreadCount: 1),
  ];

  List<Message> boatsMessages = [
    Message(sender: 'John Doe', content: 'Boats available at dock...', unreadCount: 2),
    Message(sender: 'Jane Doe', content: 'Free boat rides for evacuation...', unreadCount: 3),
  ];

  List<Message> medicalAssistanceMessages = [
    Message(sender: 'NOCVolunteers', content: 'Dolo 650 3 strips available...', unreadCount: 5),
  ];

  List<Message> foodAndGroceriesMessages = [
    Message(sender: 'FoodBank', content: 'Groceries available for pickup...', unreadCount: 2),
    Message(sender: 'SuperMart', content: 'Fresh supplies just arrived...', unreadCount: 1),
  ];

  void updateMessageReadCount(Message message) {
    setState(() {
      message.unreadCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<MessageCategory> messageCategories = [];

    if (waterCanMessages.isNotEmpty) {
      messageCategories.add(MessageCategory(category: 'Request: Water Can', messages: waterCanMessages));
    }
    if (boatsMessages.isNotEmpty) {
      messageCategories.add(MessageCategory(category: 'Request: Boats', messages: boatsMessages));
    }
    if (medicalAssistanceMessages.isNotEmpty) {
      messageCategories.add(MessageCategory(category: 'Request: Medical Assistance', messages: medicalAssistanceMessages));
    }
    if (foodAndGroceriesMessages.isNotEmpty) {
      messageCategories.add(MessageCategory(category: 'Request: Food & Groceries', messages: foodAndGroceriesMessages));
    }

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: messageCategories.map((category) {
            return CategoryWidget(
              category: category,
              onMessageTap: updateMessageReadCount,
            );
          }).toList(),
        ),
      ),

    );
  }
}
