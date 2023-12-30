import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/constants/ui_constants.dart';
import 'package:splitbuddy/feature/account/widgets/feedback.dart';
import 'package:splitbuddy/feature/account/widgets/notification_preferences.dart';
import 'package:splitbuddy/providers/user_provider.dart';
import 'package:splitbuddy/themes/pallete.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  // First Section: User Profile Details
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 40,
                        child: Text("A"),
                      ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            userProvider.user.username,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            userProvider.user.email,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Spacer(), // To push the edit button to the right
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: Pallete.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  NotificationPreferences(),

                  SizedBox(height: 20),
                  FeedbackWidget(),

                  SizedBox(height: 20),
                  // Logout Button
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      shadowColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      surfaceTintColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                    ),
                    onPressed: () {
                      // Add functionality for logging out
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          color: Pallete.secondaryColor, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 20),
                  // About Section

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UIConstants.getAppTitle(18),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Version: 1.0.0"),
                      Text(
                          '© ${DateTime.now().year} STS, Inc. All rights reserved.'),
                      Text('contact@stsinc.com'),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
