import 'package:flutter/material.dart';

class NotificationModel {
  NotificationModel(this.title, this.content, [this.isExpanded = false]);
  String title;
  String content;
  bool isExpanded;
}

List<NotificationModel> getNotifications() {
  return [
    NotificationModel('Notification 1', 'This is the first notification'),
    NotificationModel('Notification 2', 'This is the second notification'),
    NotificationModel('Notification 3', 'This is the third notification'),
    // Add more notifications as needed
  ];
}

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final List<NotificationModel> _notifications = getNotifications();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _notifications[index].isExpanded = !isExpanded;
            });
          },
          children:
              _notifications.map<ExpansionPanel>((NotificationModel note) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(note.title),
                );
              },
              body: ListTile(
                title: Text(note.content),
              ),
              isExpanded: note.isExpanded,
            );
          }).toList(),
        ),
      ),
    );
  }
}
