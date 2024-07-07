import 'package:flutter/material.dart';
import 'package:untitled2/components/tags.dart';
import 'package:untitled2/maps/mapscreen.dart';
import 'package:untitled2/victim/boatpage.dart';
import 'package:untitled2/victim/chargingstation.dart';
import 'package:untitled2/victim/foodpage.dart';
import 'package:untitled2/victim/medicine.dart';
import 'package:untitled2/victim/watercanpage.dart';

class Requests extends StatelessWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RequestsPage();
  }
}

class RequestsPage extends StatefulWidget {
  const RequestsPage({Key? key}) : super(key: key);

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, bottom: 10, right: 15.0, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Requests', style: TextStyle(fontSize: 15)),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    runAlignment: WrapAlignment.spaceAround,
                    spacing: 20, // horizontal gap between tags
                    runSpacing: 20, // vertical gap between lines of tags
                    children: [
                      Tags(
                        text: 'Boats',
                        imagePath: 'assets/images/boat.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const BoatAskingPage()),
                          );
                        },
                      ),
                      Tags(
                        text: 'Foods, Groceries',
                        imagePath: 'assets/images/foods.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const FoodAskingPage()),
                          );
                        },
                      ),
                      Tags(
                        text: 'Medicines',
                        imagePath: 'assets/images/medicine.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MedicineAskingPage()),
                          );
                        },
                      ),
                      Tags(
                        text: 'Watercans',
                        imagePath: 'assets/images/watercan.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const WatercanAskingPage()),
                          );
                        },
                      ),
                      Tags(
                        text: 'Charging Station',
                        imagePath: 'assets/images/charge.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ChargingstationPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Announcements', style: TextStyle(fontSize: 15)),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    runAlignment: WrapAlignment.spaceAround,
                    spacing: 20, // horizontal gap between tags
                    runSpacing: 20, // vertical gap between lines of tags
                    children: [
                      Tags(
                        text: 'Weather Updates',
                        imagePath: 'assets/images/weather.png',
                        onTap: () {},
                        onTap: () {
                          
                        },
                      ),
                      Tags(
                        text: 'Offline Maps',
                        imagePath: 'assets/images/map.png',
                        onTap: () {},
                        onTap: () {
                          Navigator.push(context, 
                                        MaterialPageRoute(builder: (context) => ShowMap()));
                        },
                      ),
                      Tags(
                        text: 'GovernmentAlert',
                        imagePath: 'assets/images/notices.png',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
