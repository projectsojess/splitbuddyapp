import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/feature/expenses/widgets/add_items.dart';
import 'package:splitbuddy/feature/expenses/widgets/expense_list.dart';
import 'package:splitbuddy/feature/groups/widgets/members.dart';
import 'package:splitbuddy/feature/groups/widgets/overview.dart';
import 'package:splitbuddy/providers/group_provider.dart';
import 'package:splitbuddy/providers/user_provider.dart';
import 'package:splitbuddy/services/group_service.dart';
import 'package:splitbuddy/services/shared_preference_service.dart';
import 'package:splitbuddy/themes/pallete.dart';

enum GroupDetailTab {
  Overview,
  Expenses,
  Members /* Add more tabs as needed */
}

class GroupDetailScreen extends StatefulWidget {
  final int groupId;
  const GroupDetailScreen({super.key, required this.groupId});

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  late Future<int> userIdFuture;
  GroupService service = GroupService();
  GroupDetailTab _currentTab = GroupDetailTab.Expenses;

  @override
  void initState() {
    super.initState();
    userIdFuture = getUserId();
  }

  Future<int> getUserId() async {
    int id = await SharedPreferenceService.getInt("userId");
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: userIdFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching data'),
            );
          } else {
            final int userId =
                snapshot.data ?? 0; // Update userId with retrieved data
            return _buildUI(userId); // Return the UI after getting the user ID
          }
        } else {
          return Center(
            child: CircularProgressIndicator(), // Show a loading indicator
          );
        }
      },
    );
  }

  Widget _buildUI(int userId) {
    return Consumer<GroupProvider>(builder: (context, groupProvider, child) {
      var groupData = groupProvider.groups
          .firstWhere((group) => group.groupId == widget.groupId);
      double amountBorrowed = groupData.amountBorrowed;
      double amountLent = groupData.amountLent;
      bool isDebt = amountBorrowed > amountLent;
      double debt =
          isDebt ? amountBorrowed - amountLent : amountLent - amountBorrowed;

      String prefix = isDebt ? "You owe: " : "You get back: ";
      Color color = isDebt ? Colors.red : Colors.green;
      return Scaffold(
        appBar: AppBar(
          title: Text(groupData.groupName),
          actions: [
            PopupMenuButton<String>(
              icon: Icon(
                Icons.add, // Plus icon
                color: Pallete.secondaryColor, // Set the color to orange
              ),
              onSelected: (value) {
                switch (value) {
                  case 'addExpense':
                    // Navigator.push(
                    //   context,
                    //   // CreateExpenseNormal.route(friend: friends),
                    // );
                    break;
                  case 'advancedExpense':
                    // Navigate to the advanced expense screen
                    // Replace 'YourAdvancedExpenseScreen' with the actual screen you want to navigate to
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddItemScreen(
                                users: groupData.members,
                                groupId: groupData.groupId,
                                fromScreen: 'GBA',
                                items: [],
                                userId: userId,
                              )),
                    );
                    break;
                  // Add mor
                  // Add more cases for other actions/screens
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'addExpense',
                  child: Text('Add Expense'),
                ),
                const PopupMenuItem<String>(
                  value: 'advancedExpense',
                  child: Text('Split a bill'),
                ),
                // Add more PopupMenuItems for other actions
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Consumer<UserProvider>(
              builder: (context, userProvider, child) => Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    prefix,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Pallete.textColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    debt.toStringAsFixed(2) + userProvider.user.displayCurrency,
                    style: TextStyle(
                      color: color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                // color: Pallete.cardBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Loop through enum values to create buttons dynamically
                  for (GroupDetailTab tab in GroupDetailTab.values)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentTab = tab;
                        });
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8.0), // Set your desired border radius here
                              // You can also adjust other properties like side for a border
                              // side: BorderSide(color: Colors.red, width: 2.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              _currentTab == tab
                                  ? Pallete.secondaryColor
                                  : Pallete.buttonPrimaryColor)),

                      child: Text(
                        _tabName(tab),
                        style: TextStyle(
                          color: _currentTab == tab
                              ? Colors.white
                              : Pallete.textColor,
                        ),
                      ), // Get tab name dynamically
                    ),
                ],
              ),
            ),
            _currentTab == GroupDetailTab.Expenses
                ? ExpenseList(
                    groupData: groupData,
                    userId: userId,
                  )
                : _currentTab == GroupDetailTab.Overview
                    ? OverViewTab(groupData: groupData, userId: userId)
                    : MembersList(
                        members: groupData.members,
                      )
          ],
        ),
      );
    });
  }

  String _tabName(GroupDetailTab tab) {
    // Function to get tab names based on enum values
    switch (tab) {
      case GroupDetailTab.Expenses:
        return 'Expenses';
      case GroupDetailTab.Members:
        return 'Members';
      case GroupDetailTab.Overview:
        return 'Overview'; // Modify as needed for additional tabs
    }
  }
}
