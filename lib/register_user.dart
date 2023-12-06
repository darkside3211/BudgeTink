import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '', _username = '', _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              onSaved: (value) => _email = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Username'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
              onSaved: (value) => _username = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              onSaved: (value) => _password = value!,
            ),
            ElevatedButton(
              child: const Text('Register'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // Check if the email is already registered
                  final users = await FirebaseFirestore.instance
                      .collection('users')
                      .where('email', isEqualTo: _email)
                      .get();

                  if (users.docs.isNotEmpty) {
                    // Email already registered
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Email already registered')),
                    );
                    return;
                  }

                  // Check if the username is already taken
                  final usernames = await FirebaseFirestore.instance
                      .collection('users')
                      .where('username', isEqualTo: _username)
                      .get();

                  if (usernames.docs.isNotEmpty) {
                    // Username already taken
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Username already taken')),
                    );
                    return;
                  }

                  // Register the user
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: _email,
                      password: _password,
                    );

                    // Save the username in Firestore
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userCredential.user!.uid)
                        .set({
                      'username': _username,
                      'email': _email,
                    });

                    // Registration successful
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registration successful')),
                    );

                    // Navigate back to the login screen
                    Navigator.pop(context);
                  } on FirebaseAuthException catch (e) {
                    // Registration failed
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Registration failed: ${e.message}')),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
