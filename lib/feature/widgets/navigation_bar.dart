import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/constants/constants.dart';
import 'package:splitbuddy/feature/groups/views/groups_screen.dart';
import 'package:splitbuddy/feature/account/views/account_screen.dart';
import 'package:splitbuddy/feature/friends/views/friends_screen.dart';
import 'package:splitbuddy/feature/home/views/transactions_screen.dart';
import 'package:splitbuddy/providers/user_provider.dart';
import 'package:splitbuddy/themes/pallete.dart';

class AppNavigationBar extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AppNavigationBar());

  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    FriendsScreen(),
    GroupsScreen(),
    TransactionsScreen(),
    AccountScreen(),
  ];
  void navidationToScreen(int index) {
    setState(() {
      _currentIndex = index; // Set the index for the GroupsScreen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(context, CreateExpenseNormal.route());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Consumer<UserProvider>(
        builder: (context, userProvider, child) => BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildNavBarItem(Icons.person, 0),
              buildNavBarItem(Icons.group, 1),
              buildNavBarItem(
                  UIConstants.getCurrencyIcon(userProvider.user.currency)!, 2),
              buildNavBarItem(Icons.account_circle, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color:
                  _currentIndex == index ? Pallete.secondaryColor : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
