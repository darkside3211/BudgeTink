import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 186, 218, 5),
      body: Center(
        child: Text(
          'Analytics',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
