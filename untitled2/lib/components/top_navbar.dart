import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/pages/role_selection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60.0);

  Future<void> signOut(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RoleSelection()));
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.menu, 
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          // Handle menu button press
        },
      ),
      title: Text(
        'Crisis.',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 30,
          letterSpacing: 1.5,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.logout_outlined, color: Colors.white, size: 30,),
          onPressed: () async{
            await FirebaseAuth.instance.signOut();
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('user', 'illai');
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RoleSelection()));
          },
        ),
      ],
      backgroundColor: Colors.black,
      elevation: 0, // Remove shadow/elevation
    );
  }
}
