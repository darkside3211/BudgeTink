import 'package:budgetink/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_user.dart';
import 'package:gap/gap.dart';
import 'package:animations/animations.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Added this line
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const Gap(20),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential =
                        await _auth.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    if (!mounted) return;
                    // Use PageRouteBuilder for custom transition
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const MyHomePage(title: 'Flutter Demo Home Page'),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    String errorMessage;
                    switch (e.code) {
                      case 'invalid-email':
                        errorMessage = "The email address is badly formatted.";
                        break;
                      case 'user-not-found':
                        errorMessage = "No user found for that email.";
                        break;
                      case 'wrong-password':
                        errorMessage = "Wrong password provided for that user.";
                        break;
                      default:
                        errorMessage =
                            "Something went wrong. Please try again later.";
                    }
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(errorMessage)),
                    );
                  }
                },
                child: const Text('Login'),
              ),
              ElevatedButton(
                child: const Text('Create an account'),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const RegisterPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
