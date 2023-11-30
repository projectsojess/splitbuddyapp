import 'package:flutter/material.dart';
import 'package:splitbuddy/themes/pallete.dart';

class ExpenseOptions extends StatefulWidget {
  final ValueChanged<int> onPaidByChanged;
  final ValueChanged<String> onSplitTypeChanged;
  final Function(DateTime selectedDate) onDateSelected;
  final TextEditingController shareController;
  final Map<int, String> paidByOptions;

  const ExpenseOptions(
      {super.key,
      required this.onPaidByChanged,
      required this.onSplitTypeChanged,
      required this.onDateSelected,
      required this.shareController,
      required this.paidByOptions});

  @override
  State<ExpenseOptions> createState() => _ExpenseOptionsState();
}

class _ExpenseOptionsState extends State<ExpenseOptions> {
  // Default paid by yourself
  String _splitType = 'E'; // Default split type is equally

  DateTime _selectedDate = DateTime.now(); // Store selected date

  late Map<String, String> _shareTypeOptions;
  @override
  void initState() {
    super.initState();

    _shareTypeOptions = {
      'E': 'Equally',
      'P': 'Percentage',
      'S': 'No of shares'
    };
  }

  @override
  Widget build(BuildContext context) {
    int _paidBy = widget.paidByOptions.keys.first;
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
              items: widget.paidByOptions.entries
                  .map((MapEntry<int, String> entry) {
                return DropdownMenuItem<int>(
                  value: entry.key,
                  child: Text(
                    entry.value,
                    style: TextStyle(color: Colors.orange),
                  ),
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
                  widget.onSplitTypeChanged(_shareTypeOptions[newValue]!);
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
              color: Colors.orange, // Orange color for the icon
            ),
          ],
        ),
        if (_splitType != 'E') ...[
          SizedBox(height: 10), // Add some space between lines
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Container(
                  width: 60, // Width of the input field
                  child: TextField(
                    textAlign: TextAlign.center, // Center align text
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.orange,
                    decoration: InputDecoration(
                      hintText: _splitType == 'P' ? ' %' : 'No.',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.orange), // Orange underline border
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .orange), // Orange highlight border when selected
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
