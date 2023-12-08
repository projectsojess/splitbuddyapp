import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:splitbuddy/common/utils.dart';
import 'package:splitbuddy/dtos/items.dart';
import 'package:splitbuddy/feature/expenses/views/create_expense_adv.dart';
import 'package:splitbuddy/feature/expenses/widgets/shares_dialogue.dart';
import 'package:splitbuddy/themes/pallete.dart';

class AddItemScreen extends StatefulWidget {
  final Map<int, String> users;
  final int? userToFriendId;
  final String fromScreen;
  final int? groupId;

  const AddItemScreen(
      {super.key,
      required this.users,
      this.groupId,
      this.userToFriendId,
      required this.fromScreen});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Map<String, String> _shareTypeOptions;
  List<Item> items = [];
  int itemLength = 0;

  int _selectedUser = 0;

  void addItem() {
    setState(() {
      items.add(Item(
        name: '',
        amount: 0,
        quantity: 1,
        usersInvolved: [],
        totalShares: 0,
        shareType: 'T',
        shareValues: {},
      ));
    });
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

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
          child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              SizedBox(height: 20),
              for (int i = 0; i < items.length; i++)
                Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Item ${i + 1}',
                              style: TextStyle(
                                color: Pallete.inputLabelTextColor,
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _deleteItem(i);
                              },
                              icon: Icon(Icons.clear),
                              color: Colors.red,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a item name';
                                  }
                                  return null;
                                },
                                decoration:
                                    customInputFieldDecoration('', 'Name'),
                                onChanged: (value) {
                                  setState(() {
                                    items[i].name = value;
                                  });
                                },
                                cursorColor: Pallete.secondaryColor,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(
                                      r'^[a-zA-Z0-9\s]*$')), // Allow letters, numbers, and spaces
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                initialValue: items[i].quantity.toString(),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a quantity';
                                  }
                                  return null;
                                },
                                decoration:
                                    customInputFieldDecoration('', 'No\'s'),
                                onChanged: (value) {
                                  setState(() {
                                    items[i].quantity =
                                        int.tryParse(value) ?? 0;
                                  });
                                },
                                cursorColor: Pallete.secondaryColor,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.deny(RegExp(
                                      r'[^\d]')), // Deny input other than digits
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'^0+')), // Deny leading zeros
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a amount';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    items[i].amount =
                                        double.tryParse(value) ?? 0;
                                  });
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.deny(RegExp(
                                      r'[^\d]')), // Deny input other than digits
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'^0+')), // Deny leading zeros
                                ],
                                decoration:
                                    customInputFieldDecoration('', 'Price'),
                                cursorColor: Pallete.secondaryColor,
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
                                            if (values.length < 2) {
                                              items[i].shareType = 'T';
                                            } else {
                                              items[i].shareType = 'E';
                                            }
                                            items[i].usersInvolved = values;
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
                            if (items[i].usersInvolved!.length > 1) ...[
                              Text(
                                'Split Type:',
                                style: TextStyle(
                                  color: Pallete.inputLabelTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              DropdownButton<String>(
                                value: items[i].shareType,
                                onChanged: (newValue) {
                                  if (newValue != 'E') {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SharesDialogue(
                                          users: widget.users,
                                          item: items[i],
                                        );
                                      },
                                    );
                                    setState(() {
                                      items[i].shareType = newValue!;
                                    });
                                  } else {
                                    setState(() {
                                      items[i].shareType = newValue!;
                                    });
                                  }
                                },
                                items:
                                    _shareTypeOptions.keys.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(_shareTypeOptions[value]!),
                                  );
                                }).toList(),
                              ),
                              if (items[i].shareType != 'E') ...[
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Edit Values:',
                                  style: TextStyle(
                                    color: Pallete.inputLabelTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SharesDialogue(
                                                  users: widget.users,
                                                  item: items[i]);
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.edit)))
                              ]
                            ],
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
                        if (items.length > 0) {
                          if (items[items.length - 1].usersInvolved!.isEmpty) {
                            showSnackbar(context,
                                "Please add atleast one payee before adding another item");
                          } else {
                            if (_formKey.currentState!.validate()) {
                              if (items[items.length - 1].shareType == 'P') {
                                double totalShares =
                                    items[items.length - 1].totalShares!;
                                if (totalShares != 100) {
                                  showSnackbar(context,
                                      "Total percentage doesn't add upto 100");
                                } else {
                                  addItem();
                                }
                              } else {
                                addItem();
                              }
                            }
                          }
                        } else {
                          addItem();
                        }
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
                        if (_formKey.currentState!.validate()) {
                          if (items[items.length - 1].usersInvolved!.isEmpty) {
                            showSnackbar(context,
                                "Pleae select atleast one user for ${items[items.length - 1].name}");
                          } else {
                            Navigator.push(
                                context,
                                CreateExpenseAdvanced.route(
                                    users: widget.users,
                                    items: items,
                                    fromScreen: widget.fromScreen,
                                    userToFriendId: widget.userToFriendId,
                                    groupId: widget.groupId));
                          }
                        }
                      },
                      label: Text('Next'),
                    ),
                  ]
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
