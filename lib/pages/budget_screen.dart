import 'package:flutter/material.dart';
import 'package:budgetink/main.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  double income = 0.0;
  double expenses = 0.0;
  double savings = 0.0;

  void updateIncome(String value) {
    if (value.isNotEmpty) {
      try {
        double incomeValue = double.parse(value);
        setState(() {
          income = incomeValue;
        });
        updateSavings();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid input:  is not a number.')),
        );
      }
    }
  }

  void updateExpenses(String value) {
    if (value.isNotEmpty) {
      try {
        double expenseValue = double.parse(value);
        setState(() {
          expenses = expenseValue;
        });
        updateSavings();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid input:  is not a number.')),
        );
      }
    }
  }

  void updateSavings() {
    setState(() {
      savings = income - expenses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 22, 125, 165),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                updateIncome(value);
                updateSavings();
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Income'),
            ),
            TextField(
              onChanged: (value) {
                updateExpenses(value);
                updateSavings();
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Expenses'),
            ),
            ElevatedButton(
              onPressed: () {
                updateData(income);
              },
              child: Text('Update Heatmap'),
            ),
            Text('Savings: ${savings.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
