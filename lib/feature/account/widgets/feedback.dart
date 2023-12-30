import 'package:flutter/material.dart';

class FeedbackWidget extends StatelessWidget {
  const FeedbackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Feedback',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ListTile(
          leading: Icon(Icons.contact_support),
          title: Text('Contact Us'),
          onTap: () {
            // Implement contact us functionality
          },
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text('Rate Us'),
          onTap: () {
            // Implement rate us functionality
          },
        ),
      ],
    );
  }
}
