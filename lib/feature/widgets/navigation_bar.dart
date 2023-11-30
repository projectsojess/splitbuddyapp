import 'package:flutter/material.dart';
import 'package:splitbuddy/feature/groups/views/group_screen.dart';
import 'package:splitbuddy/feature/account/views/account_screen.dart';
import 'package:splitbuddy/feature/expenses/views/create_expense.dart';
import 'package:splitbuddy/feature/friends/views/friends_screen.dart';
import 'package:splitbuddy/feature/home/views/home_content.dart';
import 'package:splitbuddy/themes/pallete.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeContent(),
    FriendsScreen(),
    GroupsScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, CreateExpenseNormal.route());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            buildNavBarItem(Icons.home, 0),
            buildNavBarItem(Icons.people_alt, 1),
            buildNavBarItem(Icons.group_outlined, 2),
            buildNavBarItem(Icons.account_circle, 3),
          ],
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
