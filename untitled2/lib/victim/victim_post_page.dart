import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/components/post_component.dart'; // Make sure the import path is correct

class VictimPosts extends StatelessWidget {
  const VictimPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return VictimPostsPage();
  }
}

class VictimPostsPage extends StatefulWidget {
  const VictimPostsPage({super.key});

  @override
  State<VictimPostsPage> createState() => _VictimPostsPageState();
}

class _VictimPostsPageState extends State<VictimPostsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _posts = [];

  @override
  void initState() {
    super.initState();
    _retrievePosts();
  }

  Future<void> _retrievePosts() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('posts').get();
      setState(() {
        _posts = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } catch (e) {
      print("Error getting documents : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: _posts.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
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
                      // imageUrl: ,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
