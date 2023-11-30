import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/dtos/friendResponse.dart';
import 'package:splitbuddy/providers/user_provider.dart';

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
  final TextEditingController _shareController = TextEditingController();

  int _paidBy = 0; // Default paid by yourself
  String _splitType = 'E'; // Default split type is equally
  DateTime _selectedDate = DateTime.now(); // Default selected date

  void handlePaidByChanged(int newValue) {
    setState(() {
      _paidBy = newValue;
    });
  }

  void handleSplitTypeChanged(String newValue) {
    setState(() {
      _splitType = newValue;
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
  }

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _untaxedAmountController.dispose();
    _taxController.dispose();
    _serviceChargeController.dispose();
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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Create Normal Expense',
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
                      shareController: _shareController,
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
                    ElevatedButton(
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

                          // Handle the submitted data as needed
                          print('Amount: $amount');
                          print('Description: $description');
                          print('Untaxed Amount: $untaxedAmount');
                          print('Tax: $tax%');
                          print('Service Charge: $serviceCharge%');
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                )),
          ),
        ));
  }

  // int getCurentUserId() {
  //   final user = Provider.of<UserProvider>(context).user;
  //   return user.userId;
  // }
}
