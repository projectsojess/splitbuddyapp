import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/dtos/items.dart';
import 'package:splitbuddy/feature/expenses/widgets/expense_form_adv.dart';
import 'package:splitbuddy/feature/expenses/widgets/expense_options_ad.dart';
import 'package:splitbuddy/services/expense_service.dart';
import 'package:splitbuddy/services/shared_preference_service.dart';

class CreateExpenseAdvanced extends StatefulWidget {
  final Map<int, String> users;
  final int userId;
  final int? userToFriendId;
  final int? groupId;
  final List<Item>? items;
  final String fromScreen;
  final ExpenseData? expenseData;

  static route({
    required Map<int, String> users,
    required int userId,
    List<Item>? items,
    required String fromScreen,
    int? groupId,
    int? userToFriendId,
    ExpenseData? expenseData,
  }) =>
      MaterialPageRoute(
          builder: (context) => CreateExpenseAdvanced(
                users: users,
                items: items,
                fromScreen: fromScreen,
                groupId: groupId,
                userToFriendId: userToFriendId,
                expenseData: expenseData,
                userId: userId,
              ));

  const CreateExpenseAdvanced(
      {super.key,
      required this.users,
      this.items,
      this.userToFriendId,
      this.groupId,
      required this.fromScreen,
      this.expenseData,
      required this.userId});

  @override
  State<CreateExpenseAdvanced> createState() => _CreateExpenseNormalState();
}

class _CreateExpenseNormalState extends State<CreateExpenseAdvanced> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ExpenseService service = ExpenseService();

  int _paidBy = 0;
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
        fromScreen: widget.fromScreen,
        date: _selectedDate.toIso8601String(),
        description: descrptionController.text,
        userToFriendId: widget.userToFriendId,
        groupId: widget.groupId,
        tax: double.tryParse(taxController.text) ?? 0,
        untaxedAmount: double.tryParse(untaxedAmountController.text) ?? 0,
        totalAmount: double.tryParse(amountController.text) ?? 0,
        serviceCharge: double.tryParse(serviceChargeController.text) ?? 0,
        items: widget.items!);
  }

  void editExpense(int expenseId, int createdById) {
    service.editExpense(
        createdById: createdById,
        expenseId: expenseId,
        context: context,
        payerId: _paidBy,
        fromScreen: widget.fromScreen,
        date: _selectedDate.toIso8601String(),
        description: descrptionController.text,
        userToFriendId: widget.userToFriendId,
        groupId: widget.groupId,
        tax: double.tryParse(taxController.text) ?? 0,
        untaxedAmount: double.tryParse(untaxedAmountController.text) ?? 0,
        totalAmount: double.tryParse(amountController.text) ?? 0,
        serviceCharge: double.tryParse(serviceChargeController.text) ?? 0,
        items: widget.items!);
  }

  @override
  void initState() {
    super.initState();
    _paidBy = widget.expenseData != null
        ? widget.expenseData!.payer.payerId
        : widget.userId;
    widget.items!.forEach((item) {
      _untaxedAmount += (item.amount * item.quantity);
    });
    untaxedAmountController.text = _untaxedAmount.toStringAsFixed(2);
    if (widget.fromScreen == 'GBAE') {
      taxController.text = widget.expenseData!.tax.toString();
      serviceChargeController.text =
          widget.expenseData!.serviceCharge.toString();
      descrptionController.text = widget.expenseData!.description;
      _selectedDate = widget.expenseData!.date;
    }
    amountController.text = _untaxedAmount.toStringAsFixed(2);
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
                      userId: widget.userId,
                      onPaidByChanged: handlePaidByChanged,
                      onDateSelected: handleDateSelected,
                      selectedDate: _selectedDate,
                      paidByOptions: widget.users,
                      paidByInitialValue: _paidBy,
                    ),
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
                    if (widget.fromScreen == 'GBA') ...[
                      ElevatedButton.icon(
                        icon: Icon(Icons.add),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          onPrimary: Colors.white,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addExpense();
                          }
                        },
                        label: Text('Add Expense'),
                      ),
                    ],
                    if (widget.fromScreen == 'GBAE') ...[
                      ElevatedButton(
                        child: Text('Save'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          onPrimary: Colors.white,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            editExpense(widget.expenseData!.expenseId,
                                widget.expenseData!.createdById);
                          }
                        },
                      ),
                    ]
                  ],
                )),
          ),
        ));
  }
}
