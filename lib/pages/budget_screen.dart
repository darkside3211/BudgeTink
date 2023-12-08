import 'package:flutter/material.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 204, 22, 189),
      body: Center(
        child: Text(
          'Budget',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
