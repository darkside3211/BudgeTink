import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Text(
          'Analytics',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
