import 'package:flutter/material.dart';
import 'package:splitbuddy/constants/ui_constants.dart';

class NotificationPreferences extends StatefulWidget {
  const NotificationPreferences({super.key});

  @override
  State<NotificationPreferences> createState() =>
      _NotificationPreferencesState();
}

class _NotificationPreferencesState extends State<NotificationPreferences> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notification Preferences',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ListTile(
          title: Text('Push Notifications'),
          trailing: UIConstants.getSwitch(() {}, true),
        ),
        ListTile(
          title: Text('Email Notifications'),
          trailing: UIConstants.getSwitch(() {}, false),
        ),
      ],
    );
  }
}
