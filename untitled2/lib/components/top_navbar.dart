import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.menu, 
          color: Colors.black,
          size: 30,
        ),
        onPressed: () {
          // Handle menu button press
        },
      ),
      title: Text(
        'Crisis.',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.black, size: 30,),
          onPressed: () {
            // Handle alert button press
          },
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0, // Remove shadow/elevation
    );
  }
}
