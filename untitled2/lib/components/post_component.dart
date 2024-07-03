import 'package:flutter/material.dart';

class Content extends StatefulWidget {

  final String? profilePicUrl;
  final String name;
  final String location;
  final String content;
  final String? imageUrl;

  Content({
    this.profilePicUrl,
    required this.name,
    required this.location,
    required this.content,
    this.imageUrl,
  });

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0), // Add padding around the container
      child: SingleChildScrollView( 
        child: Container(
        padding: const EdgeInsets.all(16.0), // Add padding inside the container
        decoration: BoxDecoration(
          color: Colors.grey[200], // Background color for the container
          borderRadius: BorderRadius.circular(5.0), // Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start
              children: [
                CircleAvatar(
                  radius: 25.0, // Radius of the profile picture
                  backgroundImage: widget.profilePicUrl != null
                      ? AssetImage(widget.profilePicUrl!) 
                      : AssetImage('/home/vishwaa-arumugam/Documents/GitHub/Crisis/crisis_client/lib/images/profile.jpg'), // Fallback to a default asset path
                ),
                SizedBox(width: 10.0), // Spacing between the image and text
                // Profile Name and Location
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.location,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20), // Spacing between the row and the paragraph
            // Paragraph with "Read more" functionality
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.content,
                  maxLines: isExpanded ? null : 4, // Show all lines if expanded
                  overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis, // Ellipsis if not expanded
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Text(
                    isExpanded ? 'Read less' : 'Read more',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Spacing between the row and the rectangular image
            
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0), // Set border radius here
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrNVNd6E8DL5Gdq8cS9GTSwVTl3H-3TC0sTg&s', // URL to the rectangular image,
                height: 200.0, // Set the height of the image
                width: double.infinity, // Set the width of the image to match parent width
                fit: BoxFit.cover, // Adjust the image to cover the entire area
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
              Padding(padding: EdgeInsets.only(left: 8.0)),
              IconButton(
                onPressed: () {}, 
                icon: Icon(Icons.favorite_outline, 
                color: Colors.black,)
              ),
              Spacer(),
              IconButton(
                onPressed: () {}, 
                icon: Icon(Icons.cached, 
                color: Colors.black,)
              ),
              IconButton(
                onPressed: () {}, 
                icon: Icon(Icons.messenger_outline_rounded, 
                color: Colors.black,)
              ),
              ],
            )
          ],
        ),
      ),
    )
    );
  }
}
