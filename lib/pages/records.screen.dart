import 'package:flutter/material.dart';

class RecordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 96, 62, 219),
      body: Center(
        child: Text(
          'Records',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
