import 'package:flutter/material.dart';

class BudgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Text(
          'Budget',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
