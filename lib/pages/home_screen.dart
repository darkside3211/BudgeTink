import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:animations/animations.dart';
import 'package:budgetink/widgets/heatmap_calendar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable back button
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Gap(20), // Add a gap at the top of the column
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: OpenContainer(
                      closedBuilder:
                          (BuildContext context, VoidCallback openContainer) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            height: 50,
                            color: Colors.green,
                          ),
                        );
                      },
                      openBuilder: (BuildContext context, VoidCallback _) {
                        return Center(
                          child: HeatmapCalendarWidget(),
                        );
                      },
                    ),
                  ),
                  // Rest of your code...
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
            ],
          ),
        ),
      ),
    );
  }
}
