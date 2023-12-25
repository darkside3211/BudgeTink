import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? username;
  String? email;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  void fetchUserInfo() async {
    User? user = _auth.currentUser;
    email = user?.email;
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    username = ds['username'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: FractionallySizedBox(
          heightFactor: 0.9, // Adjust this value to move the content up or down
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150'), // Replace with user's avatar URL
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 20),
              Text('Username: $username'),
              SizedBox(height: 10),
              Text('Email: $email'),
            ],
          ),
        ),
      ),
    );
  }
}
