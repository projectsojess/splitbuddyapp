import 'package:flutter/material.dart';
import 'package:splitbuddy/common/utils.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/feature/expenses/widgets/expense_items_list.dart';
import 'package:splitbuddy/themes/pallete.dart';

class BillWidget extends StatefulWidget {
  final GroupData groupData;
  final ExpenseData expense;
  const BillWidget({super.key, required this.expense, required this.groupData});

  @override
  State<BillWidget> createState() => _BillWidgetState();
}

class _BillWidgetState extends State<BillWidget> {
  @override
  Widget build(BuildContext context) {
    double taxAmount =
        widget.expense.untaxedAmount! * (widget.expense.tax! / 100);
    double serviceChargeAmount =
        widget.expense.untaxedAmount! * (widget.expense.serviceCharge! / 100);
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Bill',
            style: TextStyle(
              fontSize: 25,
              color: Pallete.textColor,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Text(
            'No\s',
            style: TextStyle(
              color: Pallete.textColor,
              fontSize: 15,
            ),
            textAlign: TextAlign.start,
          ),
          title: Text(
            'Item name',
            style: TextStyle(
              color: Pallete.textColor,
              fontSize: 15,
            ),
          ),
          trailing: Text(
            'Price',
            style: TextStyle(
              color: Pallete.textColor,
              fontSize: 15,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        ExpenseItemsList(
          items: widget.expense.items!,
          groupData: widget.groupData,
        ),
        getUnderLine(),
        if (widget.expense.tax != 0) ...[
          ListTile(
            title: Text(
              'Tax',
              style: TextStyle(
                color: Pallete.textColor,
                fontSize: 15,
              ),
            ),
            trailing: Text(
              '${taxAmount.toStringAsFixed(2)} (${widget.expense.tax!.toStringAsFixed(2)}%)',
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
              ),
            ),
          )
        ],
        if (widget.expense.serviceCharge != 0) ...[
          ListTile(
            title: Text(
              'Service Charge',
              style: TextStyle(
                color: Pallete.textColor,
                fontSize: 15,
              ),
            ),
            trailing: Text(
              '${serviceChargeAmount.toStringAsFixed(2)} (${widget.expense.serviceCharge!.toStringAsFixed(2)}%)',
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
              ),
            ),
          )
        ],
        getUnderLine(),
        ListTile(
          title: Text(
            'Untaxed Amount',
            style: TextStyle(
              color: Pallete.textColor,
              fontSize: 15,
            ),
          ),
          trailing: Text(
            widget.expense.untaxedAmount!.toStringAsFixed(2),
            style: TextStyle(
              color: Pallete.textColor,
              fontSize: 15,
            ),
          ),
        ),
        ListTile(
          title: Text(
            'Total Amount',
            style: TextStyle(
              color: Pallete.textColor,
              fontSize: 15,
            ),
          ),
          trailing: Text(
            widget.expense.totalAmount.toStringAsFixed(2),
            style: TextStyle(
              color: Pallete.textColor,
              fontSize: 15,
            ),
          ),
        )
      ],
    );
  }
}
