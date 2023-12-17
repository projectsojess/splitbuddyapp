import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/feature/expenses/widgets/add_items.dart';
import 'package:splitbuddy/feature/expenses/widgets/expense_list.dart';
import 'package:splitbuddy/feature/groups/widgets/members.dart';
import 'package:splitbuddy/feature/groups/widgets/overview.dart';
import 'package:splitbuddy/providers/expenses_provider.dart';
import 'package:splitbuddy/services/shared_preference_service.dart';
import 'package:splitbuddy/themes/pallete.dart';

enum GroupDetailTab {
  Overview,
  Expenses,
  Members /* Add more tabs as needed */
}

class GroupDetailScreen extends StatefulWidget {
  final GroupData groupData;
  const GroupDetailScreen({super.key, required this.groupData});

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  int userId = SharedPreferenceService.getInt("userId");
  GroupDetailTab _currentTab = GroupDetailTab.Expenses;
  @override
  Widget build(BuildContext context) {
    double amountBorrowed = widget.groupData.amountBorrowed;
    double amountLent = widget.groupData.amountLent;
    bool isDebt = amountBorrowed > amountLent;
    double debt =
        isDebt ? amountBorrowed - amountLent : amountLent - amountBorrowed;

    String prefix = isDebt ? "You owe" : "You lent";
    List<ExpenseData> expenses = Provider.of<ExpensesProvider>(context)
        .expenses
        .where((element) => element.groupId == widget.groupData.groupId)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupData.groupName),
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
                              users: widget.groupData.members,
                              groupId: widget.groupData.groupId,
                              fromScreen: 'GBA',
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
                child: Text('Advanced Expense'),
              ),
              // Add more PopupMenuItems for other actions
            ],
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              color: Pallete.secondaryColor,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          prefix,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          debt.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                : const Color.fromARGB(255, 29, 28, 28))),

                    child: Text(
                      _tabName(tab),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ), // Get tab name dynamically
                  ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _currentTab == GroupDetailTab.Expenses
                ? ExpenseList(expenses: expenses, groupData: widget.groupData)
                : _currentTab == GroupDetailTab.Overview
                    ? OverViewTab()
                    : MembersList()
          ],
        ),
      ),
    );
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
