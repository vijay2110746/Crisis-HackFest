import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:untitled2/components/post_component.dart';
import 'package:untitled2/components/tags.dart';
import 'package:untitled2/components/top_navbar.dart';
import 'package:untitled2/pages/inbox_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled2/pages/request.dart';
// import 'package:untitled2/pages/request.dart';
// import 'package:untitled2/pages/account.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    PostsPage(),
    VolunteerPage(),
    InboxPage(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 0.0), // Adjust top padding as needed
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: 20.0), // Adjust top padding as needed
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: Colors.black,
          buttonBackgroundColor: Colors.black,
          height: 75,
          items: const <Widget>[
            Center(child: Icon(Icons.home, size: 22.5, color: Colors.white)),
            Center(child: Icon(Icons.request_page,size: 22.5,color: Colors.white,)),
            Center(child: Icon(Icons.notifications, size: 22.5, color: Colors.white)),
            Center(child: Icon(Icons.person, size: 22.5, color: Colors.white)),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          animationDuration: Duration(milliseconds: 400), // Adjust animation duration if needed
          animationCurve: Curves.easeInOut,
        ),
      ),
    );
  }
}

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Your content here
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
      ),
    );
  }
}


class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Notifications Screen"),
    );
  }
}



class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<Map<String, dynamic>?> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }

    String userId = user.uid;
    print(userId);

    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
    return null;
  }

  Future<void> _editDetails(Map<String, dynamic> userData) async {
    TextEditingController nameController = TextEditingController(text: userData['name']);
    TextEditingController emailController = TextEditingController(text: userData['email']);
    TextEditingController phoneController = TextEditingController(text: userData['pno']);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                // Update Firestore
                try {
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    String userId = user.uid;
                    await FirebaseFirestore.instance.collection('users').doc(userId).update({
                      'name': nameController.text,
                      'email': emailController.text,
                      'pno': phoneController.text,
                    });
                    // Refresh the state to show updated data
                    setState(() {});
                    Navigator.of(context).pop();
                  }
                } catch (e) {
                  print('Error updating user data: $e');
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No user data found'));
          }

          var userData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('lib/images/profile.jpg'),
                      radius: 55.0,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 3.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 15),
                  child: Text(
                    '${userData['name']}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 3.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 15),
                  child: Text(
                    '${userData['email']}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                  child: Text(
                    'Mobile Number',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 3.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 15),
                  child: Text(
                    '${userData['pno']}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 40, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      _editDetails(userData);
                    },
                    child: Text(
                      'EDIT DETAILS',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      minimumSize: MaterialStateProperty.all<Size>(Size(40, 50)),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class VolunteerPage extends StatelessWidget {
  const VolunteerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: RequestsPage(),
    );
  }
}

