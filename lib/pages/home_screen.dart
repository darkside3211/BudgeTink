import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:animations/animations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable back button
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: OpenContainer(
                    closedBuilder:
                        (BuildContext context, VoidCallback openContainer) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(
                            50), // Adjust the value as needed
                        child: Container(
                          height: 50,
                          color: Colors.green,
                        ),
                      );
                    },
                    openBuilder: (BuildContext context, VoidCallback _) {
                      // Return the destination widget here
                      // For example, a simple Text widget
                      return Center(child: Text('Destination Widget'));
                    },
                  ),
                ),
                Gap(16),
                Expanded(
                  child: OpenContainer(
                    closedBuilder:
                        (BuildContext context, VoidCallback openContainer) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(
                            50), // Adjust the value as needed
                        child: Container(
                          height: 50,
                          color: Colors.green,
                        ),
                      );
                    },
                    openBuilder: (BuildContext context, VoidCallback _) {
                      // Return the destination widget here
                      // For example, a simple Text widget
                      return Center(child: Text('Destination Widget'));
                    },
                  ),
                ),
                Gap(16), // Add another Gap widget here
                Expanded(
                  child: OpenContainer(
                    closedBuilder:
                        (BuildContext context, VoidCallback openContainer) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(
                            50), // Adjust the value as needed
                        child: Container(
                          height: 50,
                          color: Colors.green,
                        ),
                      );
                    },
                    openBuilder: (BuildContext context, VoidCallback _) {
                      // Return the destination widget here
                      // For example, a simple Text widget
                      return Center(child: Text('Destination Widget'));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
