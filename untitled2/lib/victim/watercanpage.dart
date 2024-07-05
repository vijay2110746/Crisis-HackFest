import 'package:flutter/material.dart';
import 'package:untitled2/components/top_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// void main() {
//   runApp(Watercan());
// }

class Watercan extends StatelessWidget {
  const Watercan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WatercanAskingPage(),
    );
  }
}

class WatercanAskingPage extends StatefulWidget {
  const WatercanAskingPage({super.key});

  @override
  State<WatercanAskingPage> createState() => _WatercanAskingPageState();
}

class _WatercanAskingPageState extends State<WatercanAskingPage> {
  var _name;
  var _area;
  var _phonenumber;
  var _prioritylevel;
  var _canquantity;
  var _deliverytime;

  final _namecontroller = TextEditingController();
  final _areacontroller = TextEditingController();
  final _phonenumbercontroller = TextEditingController();
  final _prioritycontroller = TextEditingController();
  final _canquantitycontroller = TextEditingController();
  final _deliverytimecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _namecontroller.addListener(_updateText);
    _areacontroller.addListener(_updateText);
    _phonenumbercontroller.addListener(_updateText);
    _prioritycontroller.addListener(_updateText);
    _canquantitycontroller.addListener(_updateText);
    _deliverytimecontroller.addListener(_updateText);
  }

  void _updateText() {
    setState(() {
      _name = _namecontroller.text;
      _area = _areacontroller.text;
      _phonenumber = _phonenumbercontroller.text;
      _prioritylevel = _prioritycontroller.text;
      _canquantity = _canquantitycontroller.text;
      _deliverytime = _deliverytimecontroller.text;
    });
  }

  void _submitData() async {
    if (_name.isNotEmpty &&
        _area.isNotEmpty &&
        _phonenumber.isNotEmpty &&
        _prioritylevel.isNotEmpty &&
        _canquantity.isNotEmpty &&
        _deliverytime.isNotEmpty) {
      await FirebaseFirestore.instance.collection('posts').add({
        'name': _name,
        'area': _area,
        'phonenumber': _phonenumber,
        'prioritylevel': _prioritylevel,
        'canquantity': _canquantity,
        'deliverytime': _deliverytime,
        'item' : 'watercan',
        'role' : 'victim',
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request submitted successfully')),
      );
      
      _namecontroller.clear();
      _areacontroller.clear();
      _phonenumbercontroller.clear();
      _prioritycontroller.clear();
      _canquantitycontroller.clear();
      _deliverytimecontroller.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Request Water Cans',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'Name',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 450),
                  child: TextFormField(
                    controller: _namecontroller,
                    decoration: InputDecoration(
                      labelText: 'Name of the recipient',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Area',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 450),
                  child: TextFormField(
                    controller: _areacontroller,
                    decoration: InputDecoration(
                      labelText: 'Delivery area',
                      prefixIcon: Icon(Icons.place),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Phone Number',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 450),
                  child: TextFormField(
                    controller: _phonenumbercontroller,
                    decoration: InputDecoration(
                      labelText: 'Contact number',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Priority Level',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 450),
                  child: TextFormField(
                    controller: _prioritycontroller,
                    decoration: InputDecoration(
                      labelText: 'Priority level',
                      prefixIcon: Icon(Icons.priority_high),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Quantity of Water Cans',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 450),
                  child: TextFormField(
                    controller: _canquantitycontroller,
                    decoration: InputDecoration(
                      labelText: 'Number of water cans',
                      prefixIcon: Icon(Icons.water),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Preferred Delivery Time',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 450),
                  child: TextFormField(
                    controller: _deliverytimecontroller,
                    decoration: InputDecoration(
                      labelText: 'Preferred delivery time',
                      prefixIcon: Icon(Icons.access_time),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 15,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      padding: const EdgeInsets.all(20.0),
                    ),
                    onPressed: _submitData,
                    child: Text('Place Request'),
                  ),
                ),
                SizedBox(height: 25,),
                Center(
                  child: Container(
                    width: 350,
                    child: Text('A volunteer will contact you as soon as they’re available for your area', style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
