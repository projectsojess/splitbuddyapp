import 'package:flutter/material.dart';
import 'package:splitbuddy/feature/expenses/widgets/expense_field_adv.dart';

class ExpenseFormAdv extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController amountController;
  final TextEditingController descrptionController;
  final TextEditingController untaxedAmountController;
  final TextEditingController taxController;
  final TextEditingController serviceChargeController;
  final double intialUntaxedAmount;

  const ExpenseFormAdv(
      {super.key,
      required this.formKey,
      required this.amountController,
      required this.descrptionController,
      required this.untaxedAmountController,
      required this.taxController,
      required this.serviceChargeController,
      required this.intialUntaxedAmount});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ExpenseField(
            editingController: descrptionController,
            icon: Icons.description,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
            label: 'Description',
          ),
          SizedBox(
            height: 20,
          ),
          ExpenseField(
            editingController: taxController,
            icon: Icons.calculate,
            validator: (value) {
              return null;
            },
            label: 'Tax(%)',
          ),
          SizedBox(height: 20),
          ExpenseField(
            editingController: serviceChargeController,
            hintText: '(Optional)',
            icon: Icons.calculate,
            validator: (value) {
              return null;
            },
            label: 'Service Charge(%)',
          ),
          SizedBox(
            height: 20,
          ),
          ExpenseField(
            editingController: untaxedAmountController,
            icon: Icons.money_off,
            label: 'Untaxed Amount',
          ),
          SizedBox(height: 20),
          ExpenseField(
            editingController: amountController,
            icon: Icons.attach_money,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an amount';
              }
              return null;
            },
            label: 'Total Amount',
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
