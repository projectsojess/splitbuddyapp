import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/dtos/friendResponse.dart';
import 'package:splitbuddy/providers/user_provider.dart';
import 'package:splitbuddy/services/expense_service.dart';

import '../widgets/widgets.dart';

class CreateExpenseNormal extends StatefulWidget {
  final List<FriendResponse> friend;

  static route({required List<FriendResponse> friend}) => MaterialPageRoute(
      builder: (context) => CreateExpenseNormal(friend: friend));

  const CreateExpenseNormal({super.key, required this.friend});

  @override
  State<CreateExpenseNormal> createState() => _CreateExpenseNormalState();
}

class _CreateExpenseNormalState extends State<CreateExpenseNormal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _untaxedAmountController =
      TextEditingController();
  final TextEditingController _taxController = TextEditingController();
  final TextEditingController _serviceChargeController =
      TextEditingController();

  int _paidBy = 0; // Default paid by yourself
  String _splitType = 'E'; // Default split type is equally
  DateTime _selectedDate = DateTime.now(); // Default selected date
  int _payee = 0;

  Map<int, TextEditingController> _shareControllers = {};

  void handlePaidByChanged(int newValue) {
    setState(() {
      _paidBy = newValue;
    });
  }

  void handleSplitTypeChanged(String newValue) {
    setState(() {
      _splitType = newValue;
      _payee = widget.friend[0].userToFriendId;
    });
  }

  void handleDateSelected(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_calculateUntaxedAmount);
    _taxController.addListener(_calculateUntaxedAmount);
    _serviceChargeController.addListener(_calculateUntaxedAmount);
  }

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _untaxedAmountController.dispose();
    _taxController.dispose();
    _serviceChargeController.dispose();
    _shareControllers.forEach((key, controller) {
      controller.dispose();
    });

    _amountController.removeListener(_calculateUntaxedAmount);
    _taxController.removeListener(_calculateUntaxedAmount);
    _serviceChargeController.removeListener(_calculateUntaxedAmount);
  }

  void _calculateUntaxedAmount() {
    final totalAmount = double.tryParse(_amountController.text) ?? 0.0;
    final tax = double.tryParse(_taxController.text) ?? 0.0;
    final serviceCharge = double.tryParse(_serviceChargeController.text) ?? 0.0;
    if (_showErrorForTax(tax)) {
      return;
    }
    if (tax != 0.0 && serviceCharge != 0.0) {
      double untaxedAmount = totalAmount / (1 + ((tax + serviceCharge) / 100));
      _untaxedAmountController.text = untaxedAmount.toStringAsFixed(2);
    } else if (tax != 0.0) {
      double untaxedAmount = totalAmount / (1 + (tax / 100));
      _untaxedAmountController.text = untaxedAmount.toStringAsFixed(2);
    }
  }

  bool _showErrorForTax(tax) {
    final currentamount = _amountController.text;
    if (currentamount.isNotEmpty && currentamount != '0') {
      if (tax == 0.0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please enter a valid value in the Tax field.'),
        ));
        return true;
      }
      return false;
    }
    return false;
  }

  ExpenseService service = ExpenseService();
  void addExpense() {
    final double amount = double.tryParse(_amountController.text) ?? 0.0;
    final String description = _descriptionController.text;
    final double untaxedAmount =
        double.tryParse(_untaxedAmountController.text) ?? 0.0;
    final double tax = double.tryParse(_taxController.text) ?? 0.0;
    final double serviceCharge =
        double.tryParse(_serviceChargeController.text) ?? 0.0;
    int totalshares = 0;
    Map<int, double>? shareDistribution = {};
    if (_splitType == 'S' || _splitType == 'P') {
      _shareControllers.entries.map((entry) {
        double value = double.tryParse(entry.value.text) ?? 0.0;
        totalshares += value as int;
        shareDistribution.putIfAbsent(
            entry.key, () => double.tryParse(entry.value.text) ?? 0.0);
      });
      service.createExpenseNormal(
        context: context,
        paidBy: _paidBy,
        payee: _payee,
        type: _splitType,
        date: _selectedDate,
        description: _descriptionController.text.trim(),
        shareDistribution: shareDistribution,
        totalShares: totalshares,
        tax: tax,
        untaxedAmount: untaxedAmount,
        serviceCharge: serviceCharge,
        totalAmount: amount,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    _paidBy = user.userId;
    // Obtain the current user ID from the provider
    int currentUserId = user.userId;

    // Create the map with the first entry (current user ID) and second entry (from object)
    final Map<int, String> paidByOptions = {
      currentUserId: 'You',
      widget.friend[0].userToFriendId: widget.friend[0].name,
    };
    _shareControllers = {
      for (var key in paidByOptions.keys) key: TextEditingController()
    };
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Split a Bill - Normal',
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ExpenseOptions(
                      onPaidByChanged: handlePaidByChanged,
                      onSplitTypeChanged: handleSplitTypeChanged,
                      onDateSelected: handleDateSelected,
                      shareControllers: _shareControllers,
                      paidByOptions: paidByOptions,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ExpenseForm(
                      formKey: _formKey,
                      amountController: _amountController,
                      descriptionController: _descriptionController,
                      untaxedAmountController: _untaxedAmountController,
                      taxController: _taxController,
                      serviceChargeController: _serviceChargeController,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: Icon(Icons.add),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Perform your submission logic here
                          final double amount =
                              double.tryParse(_amountController.text) ?? 0.0;
                          final String description =
                              _descriptionController.text;
                          final double untaxedAmount =
                              double.tryParse(_untaxedAmountController.text) ??
                                  0.0;
                          final double tax =
                              double.tryParse(_taxController.text) ?? 0.0;
                          final double serviceCharge =
                              double.tryParse(_serviceChargeController.text) ??
                                  0.0;
                          addExpense();
                          // Handle the submitted data as needed
                          print('Amount: $amount');
                          print('Description: $description');
                          print('Untaxed Amount: $untaxedAmount');
                          print('Tax: $tax%');
                          print('Service Charge: $serviceCharge%');
                        }
                      },
                      label: Text('Add '),
                    ),
                  ],
                )),
          ),
        ));
  }
}
