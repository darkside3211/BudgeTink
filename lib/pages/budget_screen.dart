import 'package:flutter/material.dart';
import 'package:budgetink/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<void> saveSavings() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DateTime now = DateTime.now();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('savings')
          .doc(now.toIso8601String())
          .set({
        'amount': savings,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Your savings have been saved!')),
      );
    } else {
      print('No user is signed in');
    }
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
            Text('Savings: ${savings.toStringAsFixed(2)}'),
            ElevatedButton(
              onPressed: () {
                saveSavings();
              },
              child: Text('Save Savings'),
            ),
          ],
        ),
      ),
    );
  }
}
