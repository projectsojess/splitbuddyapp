import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/feature/groups/widgets/summary.dart';
import 'package:splitbuddy/feature/groups/widgets/user_to_member_share.dart';
import 'package:splitbuddy/feature/groups/widgets/users_expenses_chart.dart';
import 'package:splitbuddy/themes/pallete.dart';

class OverViewTab extends StatelessWidget {
  final GroupData groupData;
  final int userId;
  final List<ExpenseData> expenses;
  const OverViewTab({
    super.key,
    required this.groupData,
    required this.expenses,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Summary(expenses: expenses, userId: userId),
              SizedBox(
                height: 20,
              ),
              UserExpensesChart(groupData: groupData),
              SizedBox(
                height: 20,
              ),
              UserToMemberShareWidget(groupData: groupData),
            ],
          )),
    );
  }
}
