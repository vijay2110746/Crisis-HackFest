import 'package:flutter/material.dart';
import 'package:untitled2/components/top_navbar.dart'; // Import the navbar file
import 'package:untitled2/components/post_component.dart'; // Import the content file
import 'package:untitled2/components/bottom_navbar.dart'; // Import the bottom navbar file

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: PostsPage(),
//     );
//   }
// }

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(), // Use the custom AppBar widget
      body: SingleChildScrollView(
        child: Column(
          children: [
            Content(
              name: 'Arjun',
              location: 'Chennai',
              content:
                  'Chennai is facing unprecedented floods due to incessant rains, with water levels rising rapidly across the city. Many low-lying areas are submerged, leading to widespread displacement and hardship for residents. The local government and NGOs are collaborating to provide relief camps and essential supplies to affected families. Efforts are ongoing to restore normalcy amidst continued rainfall and challenging conditions.',
            ),
            Content(
              name: 'Priya',
              location: 'Madurai',
              content:
                  'Madurai is grappling with severe flooding following heavy monsoon showers, causing rivers and lakes to overflow into residential areas. Thousands of families are stranded without access to clean water and food supplies. Rescue teams are conducting round-the-clock operations to evacuate residents to safer locations and provide medical assistance to those in need. The community has come together to support each other during this challenging time.',
            ),
            Content(
              name: 'Deepika',
              location: 'Tiruchirappalli (Trichy)',
              content:
                  'Tiruchirappalli faces a severe flood crisis as torrential rains have submerged streets, homes, and agricultural fields. The floodwaters have disrupted transportation and communication networks, making it challenging for emergency services to reach affected areas. Authorities are coordinating efforts to provide emergency relief, including food supplies, clean water, and medical assistance to affected residents. The community is demonstrating resilience amidst the adversity, supporting each other through collective efforts.',
            ),
            Content(
              name: 'Karthik',
              location: 'Coimbatore',
              content:
                  'Coimbatore is witnessing a devastating flood situation as incessant rainfall has caused rivers to breach their banks, inundating neighborhoods and disrupting essential services. The local administration has launched rescue operations to evacuate residents trapped in flooded areas and set up temporary shelters for displaced families. Relief efforts are underway with volunteers distributing food, blankets, and hygiene kits to affected communities.',
            ),
            Content(
              name: 'Vishal',
              location: 'Pondicherry',
              content:
                  'Pondicherry is reeling under heavy flooding caused by incessant rainfall, with water levels rising rapidly in urban and rural areas. Thousands of homes have been inundated, forcing residents to evacuate to safer locations. Emergency response teams are working tirelessly to rescue stranded individuals and provide shelter, food, and medical care. The local administration is urging residents to remain vigilant and follow safety protocols amidst the ongoing flood emergency.',
            ),
          ],
        ),
      ), // Use the custom Content widget
      bottomNavigationBar: BottomNavBar(), // Add the BottomNavBar here
    );
  }
}
