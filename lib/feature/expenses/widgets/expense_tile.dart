import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splitbuddy/dtos/create_expense_response.dart';
import 'package:splitbuddy/dtos/expense_payee.dart';
import 'package:splitbuddy/dtos/expense_payer.dart';

class ExpenseTile extends StatelessWidget {
  final CreateExpenseResponse expense;
  final ExpensePayer payer;
  final List<ExpensePayee> payee;
  final bool isFriendPayer;

  const ExpenseTile({
    Key? key,
    required this.expense,
    required this.payer,
    required this.payee,
    required this.isFriendPayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color titleColor = isFriendPayer ? Colors.red : Colors.green;
    String paymentType = isFriendPayer ? 'You Owe' : 'Owes';

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        elevation: 0, // Remove Card's default elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateColumn(),
              SizedBox(width: 16),
              _buildExpenseDetailsColumn(),
              _buildPaymentColumn(titleColor, paymentType),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateColumn() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey, // Lighter background color
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat.MMM().format(expense.date).toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${expense.date.day}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseDetailsColumn() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            expense.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Paid by: ${payer.payerName}',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentColumn(Color titleColor, String paymentType) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          paymentType,
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '\$${payee[0].share.toString()}',
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
