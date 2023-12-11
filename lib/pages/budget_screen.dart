import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  double income = 0.0;
  double expenses = 0.0;
  double savings = 0.0;

  void updateIncome(double value) {
    setState(() {
      income = value;
    });
  }

  void updateExpenses(double value) {
    setState(() {
      expenses = value;
    });
  }

  void updateSavings() {
    setState(() {
      savings = income - expenses;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 22, 125, 165),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                updateIncome(double.parse(value));
                updateSavings();
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Income'),
            ),
            TextField(
              onChanged: (value) {
                updateExpenses(double.parse(value));
                updateSavings();
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Expenses'),
            ),
            Text('Savings: \$${savings.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
