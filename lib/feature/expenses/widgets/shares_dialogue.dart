import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splitbuddy/dtos/items.dart';

class SharesDialogue extends StatefulWidget {
  final Map<int, String> users;
  final Item item;
  const SharesDialogue({super.key, required this.users, required this.item});

  @override
  State<SharesDialogue> createState() => _SharesDialogueState();
}

class _SharesDialogueState extends State<SharesDialogue> {
  final Map<int, double> sharesP = {};
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Share Values'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int userId in widget.users.keys)
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: widget.item.shareValue![userId] != 0 &&
                            widget.item.shareValue![userId] != null
                        ? widget.item.shareValue![userId].toString()
                        : '',
                    onChanged: (value) {
                      setState(() {
                        double valueD = double.tryParse(value) ?? 0;
                        widget.item.shareValue![userId] = valueD;
                        double shareAmount = 0;
                        if (widget.item.shareType == 'P') {
                          shareAmount = (valueD * widget.item.amount) / 100;
                          sharesP[userId] = shareAmount;
                        }
                      });
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(
                          r'^\d+\.?\d{0,2}')), // Allow digits and decimal point with up to 2 decimal places
                      FilteringTextInputFormatter.deny(RegExp(r'[^\d\.]+')),
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Share value for  ${widget.users[userId]}',
                    ),
                  ),
                ),
                SizedBox(
                    width:
                        10), // Add some spacing between TextFormField and computed value
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey, // Change the color as needed
                        width: 1.0,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 20.0), // Adjust padding as needed
                  child: Text(
                    sharesP.containsKey(userId)
                        ? '${sharesP[userId]}' // Show computed value if available
                        : '',
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          Colors.green, // Change the color or style as needed
                    ),
                  ),
                ),
              ],
            )
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
