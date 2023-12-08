import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/login_screen.dart' as login_screen;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BudgeTink',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: login_screen.LoginScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedIndex = 0; // Add this line

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<String> getUserName() async {
    User? user = _auth.currentUser;
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    return ds['username'];
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    String? name = user?.displayName;
    String? email = user?.email;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu), // This is the burger menu icon
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications), // This is the notification icon
            onPressed: () {
              // Handle the notification button press here
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: FutureBuilder<String>(
                future: getUserName(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return Text(snapshot.data ?? 'No Username');
                },
              ),
              accountEmail: Text(email ?? 'No Email'),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: FlutterLogo(size: 42.0),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
              selected: _selectedIndex == 0, // Add this line
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
              selected: _selectedIndex == 1, // Add this line
            ),
            const AboutListTile(
              // Add this line
              icon: Icon(Icons.info),
              applicationName: 'App Name',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2022 Company Name',
              aboutBoxChildren: <Widget>[
                Text('This is a demo application.'),
              ],
              child: Text('About'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
