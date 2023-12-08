import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
