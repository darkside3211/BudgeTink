import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
                  child: GestureDetector(
                    onTap: () {
                      // Add your navigation code here
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          50), // Adjust the value as needed
                      child: Container(
                        height: 50,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Gap(16), // Add a Gap widget here
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Add your navigation code here
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          50), // Adjust the value as needed
                      child: Container(
                        height: 50,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Gap(16), // Add another Gap widget here
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Add your navigation code here
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          50), // Adjust the value as needed
                      child: Container(
                        height: 50,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Rest of your page here
          ],
        ),
      ),
    );
  }
}
