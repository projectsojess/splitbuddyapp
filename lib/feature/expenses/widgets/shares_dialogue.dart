import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/items.dart';

class SharesDialogue extends StatefulWidget {
  final Map<int, String> users;
  final Item item;
  const SharesDialogue({super.key, required this.users, required this.item});

  @override
  State<SharesDialogue> createState() => _SharesDialogueState();
}

class _SharesDialogueState extends State<SharesDialogue> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Share Values'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int userId in widget.users.keys)
            TextFormField(
              initialValue: widget.item.shareValue![userId] != 0 &&
                      widget.item.shareValue![userId] != null
                  ? widget.item.shareValue![userId].toString()
                  : '',
              onChanged: (value) {
                widget.item.shareValue![userId] = double.tryParse(value) ?? 0;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Share value for  ${widget.users[userId]}',
              ),
            ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            double totalShares = 0;
            widget.item.shareValue!.values.forEach((val) {
              totalShares += val;
            });
            widget.item.totalShares = totalShares;
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
