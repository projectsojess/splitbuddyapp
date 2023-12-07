import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/items.dart';
import 'package:splitbuddy/feature/expenses/widgets/expense_form_adv.dart';
import 'package:splitbuddy/feature/expenses/widgets/expense_options_ad.dart';
import 'package:splitbuddy/services/expense_service.dart';

class CreateExpenseAdvanced extends StatefulWidget {
  final Map<int, String> users;
  final int? userToFriendId;
  final int? groupId;
  final List<Item>? items;
  final String fromScreen;

  static route({
    required Map<int, String> users,
    List<Item>? items,
    required String fromScreen,
    int? groupId,
    int? userToFriendId,
  }) =>
      MaterialPageRoute(
          builder: (context) => CreateExpenseAdvanced(
                users: users,
                items: items,
                fromScreen: fromScreen,
                groupId: groupId,
                userToFriendId: userToFriendId,
              ));

  const CreateExpenseAdvanced(
      {super.key,
      required this.users,
      this.items,
      this.userToFriendId,
      this.groupId,
      required this.fromScreen});

  @override
  State<CreateExpenseAdvanced> createState() => _CreateExpenseNormalState();
}

class _CreateExpenseNormalState extends State<CreateExpenseAdvanced> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ExpenseService service = ExpenseService();
  int _paidBy = 0; // Default paid by yourself
  String _splitType = 'E'; // Default split type is equally
  DateTime _selectedDate = DateTime.now();
  final amountController = TextEditingController();
  final descrptionController = TextEditingController();
  final untaxedAmountController = TextEditingController();
  final taxController = TextEditingController();
  final serviceChargeController = TextEditingController();
  double _untaxedAmount = 0;
  void handlePaidByChanged(int newValue) {
    setState(() {
      _paidBy = newValue;
    });
  }

  void handleDateSelected(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  void calculateTotalAmount() {
    final double tax = double.tryParse(taxController.text) ?? 0;
    final double serviceCharge =
        double.tryParse(serviceChargeController.text) ?? 0;
    final totalAmount =
        _untaxedAmount + (_untaxedAmount * ((tax + serviceCharge) / 100));
    amountController.text = totalAmount.toString();
  }

  void addExpense() {
    service.addExpenseAdvanced(
        context: context,
        payerId: _paidBy,
        date: _selectedDate.toIso8601String(),
        description: descrptionController.text,
        userToFriendId: widget.userToFriendId!,
        items: widget.items!);
  }

  @override
  void initState() {
    super.initState();
    widget.items!.forEach((item) {
      _untaxedAmount += item.amount;
    });
    untaxedAmountController.text = _untaxedAmount.toString();
    taxController.addListener(calculateTotalAmount);
    serviceChargeController.addListener(calculateTotalAmount);
  }

  @override
  void dispose() {
    super.dispose();
    taxController.removeListener(calculateTotalAmount);
    serviceChargeController.removeListener(calculateTotalAmount);
    taxController.dispose();
    descrptionController.dispose();
    amountController.dispose();
    untaxedAmountController.dispose();
    serviceChargeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Split a Bill - Advanced',
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ExpenseOptionsAdv(
                        onPaidByChanged: handlePaidByChanged,
                        onDateSelected: handleDateSelected,
                        paidByOptions: widget.users),
                    SizedBox(
                      height: 20,
                    ),
                    ExpenseFormAdv(
                        formKey: _formKey,
                        intialUntaxedAmount: _untaxedAmount,
                        amountController: amountController,
                        descrptionController: descrptionController,
                        untaxedAmountController: untaxedAmountController,
                        taxController: taxController,
                        serviceChargeController: serviceChargeController),
                    ElevatedButton.icon(
                      icon: Icon(Icons.add),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Perform your submission logic here
                          // Handle the submitted data as needed
                          addExpense();
                        }
                      },
                      label: Text('Add Expense'),
                    ),
                  ],
                )),
          ),
        ));
  }
}
