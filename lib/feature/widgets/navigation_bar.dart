import 'package:flutter/material.dart';
import 'package:splitbuddy/feature/groups/views/groups_screen.dart';
import 'package:splitbuddy/feature/account/views/account_screen.dart';
import 'package:splitbuddy/feature/expenses/views/create_expense.dart';
import 'package:splitbuddy/feature/friends/views/friends_screen.dart';
import 'package:splitbuddy/feature/home/views/home_content.dart';
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
    HomeContent(),
    FriendsScreen(),
    GroupsScreen(),
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
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            buildNavBarItem(Icons.home, 0),
            buildNavBarItem(Icons.person, 1),
            buildNavBarItem(Icons.group, 2),
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
