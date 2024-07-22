import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/pages/role_selection.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60.0);

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => RoleSelection()));
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('LogOut?'),
          content: Text('Are you sure, you want to logout?'),
          actions: [
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            ElevatedButton(
              child: Text('Logout'),
              onPressed: () async {
                // Handle logout logic here
                Navigator.of(context).pop(); // Dismiss the dialog
                await FirebaseAuth.instance.signOut();

                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text('Logged out successfully!'),
                //     behavior: SnackBarBehavior.floating,
                //     margin: EdgeInsets.only(bottom: 200.0),
                //   ),
                // );
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => RoleSelection()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: const Color.fromARGB(255, 0, 0, 0),
          size: 30,
        ),
        onPressed: () {
          // Handle menu button press
        },
      ),
      title: Text(
        'Crisis.',
        style: TextStyle(
          fontFamily: 'Inter',
          color: const Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            Icons.logout_rounded,
            color: const Color.fromARGB(255, 0, 0, 0),
            size: 30,
          ),
          onPressed: () {
            _showLogoutDialog(context);
          },
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0, // Remove shadow/elevation
    );
  }
}
