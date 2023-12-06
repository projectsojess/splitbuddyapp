import 'package:flutter/material.dart';
import 'package:splitbuddy/feature/expenses/widgets/share_type_field.dart';
import 'package:splitbuddy/themes/pallete.dart';

class ExpenseOptions extends StatefulWidget {
  final ValueChanged<int> onPaidByChanged;
  final ValueChanged<String> onSplitTypeChanged;
  final Function(DateTime selectedDate) onDateSelected;
  final Map<int, TextEditingController> shareControllers;
  final Map<int, String> paidByOptions;

  const ExpenseOptions(
      {super.key,
      required this.onPaidByChanged,
      required this.onSplitTypeChanged,
      required this.onDateSelected,
      required this.shareControllers,
      required this.paidByOptions});

  @override
  State<ExpenseOptions> createState() => _ExpenseOptionsState();
}

class _ExpenseOptionsState extends State<ExpenseOptions> {
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
            Text(
              'Type:',
              style: TextStyle(
                color: Pallete.inputLabelTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton<String>(
              value: _splitType,
              onChanged: (newValue) {
                setState(() {
                  _splitType = newValue!;
                  widget.onSplitTypeChanged(newValue);
                });
              },
              items: _shareTypeOptions.keys.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(_shareTypeOptions[value]!),
                );
              }).toList(),
            ),
            // Date Picker
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
              color: Pallete.secondaryColor, // Orange color for the icon
            ),
          ],
        ),
        if (_splitType != 'E') ...[
          SizedBox(height: 10),
          // Add some space between lines
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.paidByOptions.entries.map((entry) {
              int key = entry.key;
              String value = entry.value;
              widget.shareControllers
                  .putIfAbsent(key, () => TextEditingController());
              IconData icon = _splitType == 'P' ? Icons.percent : Icons.share;
              return ShareTypeField(
                  controller: widget.shareControllers[key]!,
                  name: value,
                  shareType: _splitType,
                  icon: icon);
            }).toList(),
          )
        ],
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
