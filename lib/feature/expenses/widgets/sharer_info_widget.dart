import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/services/service.dart';
import 'package:splitbuddy/themes/pallete.dart';

class SharerInfoWidget extends StatelessWidget {
  final ExpenseData expenseData;
  final bool isUserPayer;
  const SharerInfoWidget(
      {super.key, required this.expenseData, required this.isUserPayer});

  @override
  Widget build(BuildContext context) {
    int userId = SharedPreferenceService.getInt('userId');
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            'Balances',
            style: TextStyle(
              color: Pallete.textColor,
              fontSize: 25,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Icon(
            Icons.attach_money_outlined,
            color: Pallete.secondaryColor,
          ),
          title: Text(
            '${isUserPayer ? 'You' : expenseData.payer.payerName} owe',
            style: TextStyle(
              color: Pallete.textColor,
              fontSize: 15,
            ),
          ),
          trailing: Text(
            expenseData.payer.share.toStringAsFixed(2),
            style: TextStyle(
              color: Pallete.textColor,
              fontSize: 15,
            ),
          ),
        ),
        for (int i = 0; i < expenseData.payees.length; i++)
          ListTile(
            leading: Icon(
              Icons.attach_money_sharp,
              color: Pallete.secondaryColor,
            ),
            title: Text(
              '${!isUserPayer ? expenseData.payees[i].payeeId == userId ? 'You' : expenseData.payees[i].payeeName : expenseData.payees[i].payeeName} owe',
              style: TextStyle(
                color: Pallete.textColor,
                fontSize: 15,
              ),
            ),
            trailing: Text(
              expenseData.payees[i].share.toStringAsFixed(2),
              style: TextStyle(
                color: Pallete.textColor,
                fontSize: 15,
              ),
            ),
          ),
      ],
    );
  }
}
