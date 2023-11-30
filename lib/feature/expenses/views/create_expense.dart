import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class CreateExpenseNormal extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateExpenseNormal());
  const CreateExpenseNormal({super.key});

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

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _untaxedAmountController.dispose();
    _taxController.dispose();
    _serviceChargeController.dispose();
  }

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    ElevatedButton.icon(
                      onPressed: () => _selectDate(context),
                      icon: Icon(Icons.calendar_today),
                      label: Text(_selectedDate == null
                          ? 'Select Date'
                          : 'Selected Date: ${_selectedDate.toString().substring(0, 10)}'),
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
}
