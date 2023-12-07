import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:splitbuddy/common/utils.dart';
import 'package:splitbuddy/dtos/items.dart';
import 'package:splitbuddy/themes/pallete.dart';

class AddItemScreen extends StatefulWidget {
  final Map<int, String> users;

  const AddItemScreen({super.key, required this.users});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  late Map<String, String> _shareTypeOptions;
  List<Item> items = [];

  int _selectedUser = 0;

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Items'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(children: <Widget>[
            SizedBox(height: 20),
            for (int i = 0; i < items.length; i++)
              Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  items[i].name = value;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Item Name ${i + 1}',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  items[i].amount = double.tryParse(value) ?? 0;
                                });
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Amount ${i + 1}',
                              ),
                            ),
                          ),

                          // Additional fields for share options for each item
                          // Similar to previous implementation
                          // ...
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Payees',
                            style: TextStyle(
                              color: Pallete.inputLabelTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: MultiSelectChipField(
                                      showHeader: false,
                                      chipColor: Pallete.secondaryColor,
                                      textStyle: TextStyle(
                                          color: Pallete.inputLabelTextColor),
                                      items: widget.users.keys.map((e) {
                                        return MultiSelectItem<int?>(
                                          e,
                                          widget.users[e]!,
                                        );
                                      }).toList(),
                                      onTap: (values) {
                                        setState(() {
                                          items[i].usersInvolved = values;
                                          if (items[i].usersInvolved!.length <
                                              2) {
                                            items[i].shareType = 'E';
                                          }
                                          print(
                                              'users:${items[i].usersInvolved}');
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Type:',
                            style: TextStyle(
                              color: Pallete.inputLabelTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: items[i].shareType,
                              onChanged: (newValue) {
                                if (newValue != 'E' &&
                                    items[i].usersInvolved!.length < 2) {
                                  setState(() {
                                    items[i].shareType = 'E';
                                  });
                                  showSnackbar(
                                      context, 'add more than 1 payee');
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Enter Share Values'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            for (int? userId
                                                in items[i].usersInvolved!)
                                              TextFormField(
                                                onChanged: (value) {
                                                  // Implement logic to save share values for each user
                                                  // For instance, you can update your 'Item' object
                                                  // with the entered share values for each user involved
                                                  // items[i].shareValue[userId] = double.tryParse(value) ?? 0;
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      'Share value for User $userId',
                                                ),
                                              ),
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  setState(() {
                                    items[i].shareType = newValue!;
                                  });
                                }
                              },
                              items: _shareTypeOptions.keys.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(_shareTypeOptions[value]!),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    if (items.length < 15) {
                      setState(() {
                        items.add(Item(
                            name: '',
                            amount: 0,
                            usersInvolved: [],
                            shareType: 'E',
                            shareValue: {}));
                      });
                    } else {
                      // Show a message or disable button if max items reached
                    }
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add Item'),
                ),
                if (items.length > 0) ...[
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.navigate_next),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //   // Perform your submission logic here
                      //   addExpense();
                      //   // Handle the submitted data as needed
                      // }
                    },
                    label: Text('Next'),
                  ),
                ]
              ],
            )
          ]),
        ),
      ),
    );
  }
}
