import 'package:flutter/material.dart';
import 'package:splitbuddy/themes/pallete.dart';

class ExpenseOptionsAdv extends StatefulWidget {
  final ValueChanged<int> onPaidByChanged;
  final Function(DateTime selectedDate) onDateSelected;
  final Map<int, String> paidByOptions;

  const ExpenseOptionsAdv({
    super.key,
    required this.onPaidByChanged,
    required this.onDateSelected,
    required this.paidByOptions,
  });

  @override
  State<ExpenseOptionsAdv> createState() => _ExpenseOptionsState();
}

class _ExpenseOptionsState extends State<ExpenseOptionsAdv> {
  // Default paid by yourself
  String _splitType = 'E'; // Default split type is equally
  int _paidBy = 0;

  DateTime _selectedDate = DateTime.now(); // Store selected date

  late Map<String, String> _shareTypeOptions;

  Map<int, String> _paidByOptions = {};
  @override
  void initState() {
    super.initState();

    _shareTypeOptions = {
      'E': 'Equally',
      'P': 'Percentage',
      'S': 'No of shares'
    };
    _paidByOptions = widget.paidByOptions;
    _paidBy = _paidByOptions.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
              color: Pallete.secondaryColor, // Orange color for the icon
            ),
            Text(
              'Paid By:',
              style: TextStyle(
                color: Pallete.inputLabelTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton<int>(
              value: _paidBy,
              onChanged: (newValue) {
                setState(() {
                  _paidBy = newValue!;
                  widget.onPaidByChanged(newValue);
                });
              },
              items: widget.paidByOptions.keys.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(widget.paidByOptions[value]!),
                );
              }).toList(),
            ),
            // Dropdown for Split
          ],
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onDateSelected(picked);
      });
    }
  }
}
