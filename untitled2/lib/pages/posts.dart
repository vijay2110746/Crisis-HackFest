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
                  _buildPostsView(_firestore.collection('posts-volunteer')),
                  _buildPostsView(_firestore.collection('posts')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostsView(CollectionReference collection) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: StreamBuilder<QuerySnapshot>(
        stream: collection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No posts available'),
            );
          }

          // Flatten the array of posts
          List<Map<String, dynamic>> posts = [];
          for (var doc in snapshot.data!.docs) {
            if (doc.exists && doc.data() != null) {
              var data = doc.data() as Map<String, dynamic>;
              if (data.containsKey('posts')) {
                List<dynamic> docPosts = data['posts'];
                for (var post in docPosts) {
                  posts.add(post as Map<String, dynamic>);
                }
              }
            }
          }

          if (posts.isEmpty) {
            return Center(
              child: Text('No posts available'),
            );
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Content(
                  name: post['name'],
                  location: post['area'],
                  content: post['postcontent'],
                  priorityLevel: post['prioritylevel'],
                  mobilenumber: post['phonenumber'],
                  headcount: post['headcount'],
                  item: post['item'],
                  role: post['role'],
                  id:post['uid']
                  // imageUrl: ,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
