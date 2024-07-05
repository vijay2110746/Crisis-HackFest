import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/components/post_component.dart'; // Make sure the import path is correct

class VolunteerPosts extends StatelessWidget {
  const VolunteerPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return VolunteerPostsPage();
  }
}

class VolunteerPostsPage extends StatefulWidget {
  const VolunteerPostsPage({super.key});

  @override
  State<VolunteerPostsPage> createState() => _VolunteerPostsPageState();
}

class _VolunteerPostsPageState extends State<VolunteerPostsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _posts = [];
  List<Map<String, dynamic>> _victimPosts = [];

  @override
  void initState() {
    super.initState();
    _retrievePosts();
    _retrieveVictimPosts();
  }

  Future<void> _retrievePosts() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('posts-volunteer').get();
      setState(() {
        _posts = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } catch (e) {
      print("Error getting volunteer documents: $e");
    }
  }

  Future<void> _retrieveVictimPosts() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('posts').get();
      setState(() {
        _victimPosts = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } catch (e) {
      print("Error getting victim documents: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              color: Colors.black,
              child: TabBar(
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(text: 'Volunteer Posts'),
                  Tab(text: 'Victim Posts'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildPostsView(_posts),
                  _buildPostsView(_victimPosts),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostsView(List<Map<String, dynamic>> posts) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: posts.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Content(
                    // profilePicUrl: '/home/vishwaa-arumugam/Documents/GitHub/Crisis/crisis_client/lib/images/profile.jpg',
                    name: post['name'],
                    location: post['area'],
                    content: post['postcontent'],
                    priorityLevel: post['prioritylevel'],
                    mobilenumber: post['phonenumber'],
                    headcount: post['headcount'],
                    item: post['item'],
                    role: post['role'],
                    // imageUrl: ,
                  ),
                );
              },
            ),
    );
  }
}
