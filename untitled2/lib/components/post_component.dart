import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  final String? profilePicUrl;
  final String name;
  final String? priorityLevel;
  final String mobilenumber;
  final String item;
  final String headcount;
  final String location;
  final String content;
  final String? imageUrl;
  final String? role;

  Content({
    this.profilePicUrl,
    required this.name,
    this.priorityLevel,
    required this.mobilenumber,
    required this.item,
    required this.headcount,
    required this.location,
    required this.content,
    this.imageUrl,
    this.role,
  });

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: widget.profilePicUrl != null &&
                            widget.profilePicUrl!.isNotEmpty
                        ? NetworkImage(widget.profilePicUrl!)
                        : AssetImage('assets/images/default_profile.jpg')
                            as ImageProvider,
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.location,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  Spacer(),
                  if (widget.role == 'victim') ...[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.cancel_outlined, color: Colors.red[700]),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.check_circle_outline, color: Colors.green[700]),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(218, 159, 7, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        widget.mobilenumber,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  if (widget.priorityLevel != null &&
                      widget.priorityLevel!.isNotEmpty)
                    Container(
                      height: 30,
                      width: 85,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(166, 83, 230, 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          widget.priorityLevel!,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(width: 5),
                  Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(7, 218, 56, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        widget.item,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.content,
                    maxLines: isExpanded ? null : 4,
                    overflow: isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
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
              SizedBox(height: 20),
              if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    widget.imageUrl!,
                    height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(height: 5),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 8.0)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_outline, color: Colors.black),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.cached, color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.messenger_outline_rounded,
                        color: Colors.black),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
