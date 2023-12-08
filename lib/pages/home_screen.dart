import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable back button
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ExpandedContainer(color: Colors.red)));
              },
              child: Container(
                height: 200,
                color: Colors.red,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ExpandedContainer(color: Colors.green)));
              },
              child: Container(
                height: 200,
                color: Colors.green,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ExpandedContainer(color: Colors.blue)));
              },
              child: Container(
                height: 200,
                color: Colors.blue,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ExpandedContainer(color: Colors.yellow)));
              },
              child: Container(
                height: 200,
                color: Colors.yellow,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ExpandedContainer(color: Colors.purple)));
              },
              child: Container(
                height: 200,
                color: Colors.purple,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ExpandedContainer(color: Colors.orange)));
              },
              child: Container(
                height: 200,
                color: Colors.orange,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ExpandedContainer(color: Colors.pink)));
              },
              child: Container(
                height: 200,
                color: Colors.pink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandedContainer extends StatelessWidget {
  final Color color;

  ExpandedContainer({required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          color: color,
        ),
      ),
    );
  }
}
