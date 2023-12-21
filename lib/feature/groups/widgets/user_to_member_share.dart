import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/themes/pallete.dart';

class UserToMemberShareWidget extends StatelessWidget {
  final GroupData groupData;
  const UserToMemberShareWidget({super.key, required this.groupData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Balances ',
            style: TextStyle(
              fontSize: 20,
              color: Pallete.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: groupData.memberData
                .where((member) =>
                    member.amountLentToUser - member.amountOwedToUser != 0)
                .map((member) {
              double amount = member.amountOwedToUser - member.amountLentToUser;
              bool isUserLent = amount > 0;

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isUserLent
                            ? '${member.memberName} owes you '
                            : 'You owe ${member.memberName}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Pallete.textColor,
                        ),
                      ),
                      Text(
                        isUserLent
                            ? amount.toString()
                            : (-1 * amount).toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 15,
                          color: isUserLent ? Colors.green : Colors.red,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
