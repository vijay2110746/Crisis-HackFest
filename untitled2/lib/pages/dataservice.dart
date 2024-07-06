import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DataService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(String name, String email, String pno, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        String userId = user.uid;
        await _firestore.collection("users").doc(userId).set({
          "name": name,
          "email": email,
          "pno": pno,
          "password":password
        });

        print('User created successfully with UID: $userId');
      } else {
        print('User creation failed');
      }
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  Future<void> createVictim(String name, String email, String pno, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        String userId = user.uid;
        await _firestore.collection("users-victim").doc(userId).set({
          "name": name,
          "email": email,
          "pno": pno,
          "password":password
        });

        print('User created successfully with UID: $userId');
      } else {
        print('User creation failed');
      }
    } catch (e) {
      print('Error creating user: $e');
    }
  }
}

// void main(){
//   DataService e= DataService();
//   e.create();
// }