import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/user_to_member_data.dart';
import 'package:splitbuddy/feature/groups/widgets/users_expenses_chart.dart';

class OverViewTab extends StatelessWidget {
  final List<UserToMemberData> memberData;
  const OverViewTab({super.key, required this.memberData});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text('chart 1 name'),
            UserExpensesChart(memberData: memberData),
          ],
        ));
  }
}
