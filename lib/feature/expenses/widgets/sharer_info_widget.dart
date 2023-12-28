import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/services/service.dart';
import 'package:splitbuddy/themes/pallete.dart';

class SharerInfoWidget extends StatefulWidget {
  final ExpenseData expenseData;
  final bool isUserPayer;
  const SharerInfoWidget(
      {super.key, required this.expenseData, required this.isUserPayer});

  @override
  State<SharerInfoWidget> createState() => _SharerInfoWidgetState();
}

class _SharerInfoWidgetState extends State<SharerInfoWidget> {
  int userId = 0;
  @override
  void initState() {
    super.initState();
    getUserId();
  }

  void getUserId() async {
    userId = await SharedPreferenceService.getInt("userId");
  }

  @override
  Widget build(BuildContext context) {
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
            '${widget.isUserPayer ? 'You' : widget.expenseData.payer.payerName} owe',
            style: TextStyle(
              color: Pallete.textColor,
              fontSize: 15,
            ),
          ),
          trailing: Text(
            widget.expenseData.payer.share.toStringAsFixed(2),
            style: TextStyle(
              color: Pallete.textColor,
              fontSize: 15,
            ),
          ),
        ),
        for (int i = 0; i < widget.expenseData.payees.length; i++)
          ListTile(
            leading: Icon(
              Icons.attach_money_sharp,
              color: Pallete.secondaryColor,
            ),
            title: Text(
              '${!widget.isUserPayer ? widget.expenseData.payees[i].payeeId == userId ? 'You' : widget.expenseData.payees[i].payeeName : widget.expenseData.payees[i].payeeName} owe',
              style: TextStyle(
                color: Pallete.textColor,
                fontSize: 15,
              ),
            ),
            trailing: Text(
              widget.expenseData.payees[i].share.toStringAsFixed(2),
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
