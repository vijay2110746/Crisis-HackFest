import 'package:flutter/material.dart';
import 'package:untitled2/pages/loginservice.dart';
import 'package:untitled2/pages/posts.dart';
import 'role_selection.dart';
import 'package:untitled2/components/bottom_navbar.dart';
// import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final String _appName = "Crisis.";
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List<AnimationController>.generate(
      _appName.length,
          (index) => AnimationController(
        duration: Duration(milliseconds: 500),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return CurvedAnimation(parent: controller, curve: Curves.easeIn);
    }).toList();

    _startAnimations();
  }

  void _startAnimations() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(Duration(milliseconds: 300));
      _controllers[i].forward();
    }

    // Wait for 2 seconds after the last animation
    await Future.delayed(Duration(seconds: 2));


    // Check login status and navigate accordingly
    bool isLoggedIn = await LoginService.isLoggedIn();
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RoleSelection()),
      );
    }
    // Navigate to the next screen

  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _appName.split("").asMap().entries.map((entry) {
            int index = entry.key;
            String letter = entry.value;

            return FadeTransition(
              opacity: _animations[index],
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(1, 0), // Slide in from the right
                  end: Offset(0, 0),
                ).animate(_animations[index]),
                child: Text(
                  letter,
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Text('This is the next screen'),
      ),
    );
  }
}
