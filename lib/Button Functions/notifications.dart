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
  late List<NotificationModel> _notifications;
  late List<bool> _isExpanded = List<bool>.filled(_notifications.length, false);

  @override
  void initState() {
    super.initState();
    _notifications = getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _isExpanded[index] = !isExpanded;
            });
          },
          children: _notifications.asMap().entries.map((entry) {
            final int index = entry.key;
            final NotificationModel note = entry.value;
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(note.title),
                );
              },
              body: note.title == 'Notification 1'
                  ? Column(
                      children: [
                        ListTile(
                          title: Text('Placeholder Content for Notification 1'),
                        ),
                        ListTile(
                          title: Text(
                              'More Placeholder Content for Notification 1'),
                        ),
                        ListTile(
                          title: Text(
                              'Even More Placeholder Content for Notification 1'),
                        ),
                        ListTile(
                          title: Text(
                              'And Finally, Some More Placeholder Content for Notification 1'),
                        ),
                      ],
                    )
                  : ListTile(
                      title: Text(note.content),
                    ),
              isExpanded: _isExpanded[index],
            );
          }).toList(),
        ),
      ),
    );
  }
}
