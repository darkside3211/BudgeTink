import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/login_screen.dart' as login_screen;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'pages/analytics_screen.dart';
import 'pages/records.screen.dart';
import 'pages/budget_screen.dart';
import 'pages/home_screen.dart';
import 'package:animations/animations.dart';
import 'Button Functions/notifications.dart';
import 'pages/userProfile_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

Map<DateTime, int> data = {};
void updateData(double income) {
  DateTime today = DateTime.now();
  data[today] = income.toInt();
  print('Data updated: $data');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BudgeTink',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 126, 57, 247)),
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
  int _selectedIndex = 0;
  int _page = 0;
  final _pageController = PageController();
  GlobalKey _bottomNavigationKey = GlobalKey();

  final _pageOptions = [
    HomePage(),
    AnalyticsScreen(),
    BudgetScreen(),
    RecordsScreen(),
  ];

  Future<String> getUserName() async {
    User? user = _auth.currentUser;
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    return ds['username'];
  }

//test comment
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
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: "Notifications",
                transitionBuilder: (context, a1, a2, widget) {
                  final curvedValue =
                      Curves.easeInOutBack.transform(a1.value) - 1.0;
                  return Transform(
                    transform:
                        Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                    child: Opacity(
                      opacity: a1.value,
                      child: Dialog(
                        child: Container(
                          height: 400, // Set the height of the dialog
                          width: 300, // Set the width of the dialog
                          child: Notifications(),
                        ),
                      ),
                    ),
                  );
                },
                transitionDuration: Duration(milliseconds: 400),
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return Container();
                },
              );
            },
          )
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
              currentAccountPicture: GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfileScreen()),
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: FlutterLogo(size: 42.0),
                ),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
              selected: _selectedIndex == 0,
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
              selected: _selectedIndex == 1,
            ),
            const AboutListTile(
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
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          const Icon(Icons.home, size: 30),
          const Icon(Icons.add_chart, size: 30),
          const Icon(Icons.money, size: 30),
          const Icon(Icons.format_list_bulleted, size: 30),
        ],
        color: const Color.fromARGB(255, 12, 180, 49),
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white12,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 267),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return SharedAxisTransition(
            child: child,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
          );
        },
        child: _pageOptions[_page],
      ),
    );
  }
}
