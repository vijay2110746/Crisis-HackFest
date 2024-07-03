import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback? onTap;

  const Tags({
    Key? key,
    required this.text,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 28, // Adjust image size as needed
                height: 28,
                fit: BoxFit.contain, // Adjust image fit
              ),
              SizedBox(height: 8), // Adjust spacing between image and text
              Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}