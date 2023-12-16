import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:animations/animations.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

DateTime displayedMonth = DateTime.now();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Map<DateTime, int> data = {
      displayedMonth.subtract(Duration(days: 3)): 5,
      displayedMonth.subtract(Duration(days: 2)): 35,
      displayedMonth.subtract(Duration(days: 1)): 14,
      displayedMonth: 5,
    };

    Map<int, Color> colorsets = {
      1: Colors.green[100]!,
      10: Colors.green[300]!,
      30: Colors.green[500]!,
    };
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
            Gap(20), //adds a gap of 20 pixels
            GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  // Swiped right, go to previous month
                  setState(() {
                    displayedMonth =
                        DateTime(displayedMonth.year, displayedMonth.month - 1);
                  });
                } else if (details.velocity.pixelsPerSecond.dx < 0) {
                  // Swiped left, go to next month
                  setState(() {
                    displayedMonth =
                        DateTime(displayedMonth.year, displayedMonth.month + 1);
                  });
                }
              },
              child: HeatMapCalendar(
                datasets: data,
                colorsets: colorsets,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
