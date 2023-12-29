import 'package:flutter/material.dart';
import 'package:splitbuddy/themes/pallete.dart';

class MembersList extends StatefulWidget {
  final Map<int, String> members;
  const MembersList({super.key, required this.members});

  @override
  State<MembersList> createState() => _MembersListState();
}

class _MembersListState extends State<MembersList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(12),
        children: [
          SizedBox(
            height: 20,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.members.length,
            itemBuilder: (context, index) {
              final member = widget.members.entries.elementAt(index);
              return Dismissible(
                key: Key(member.key.toString()),
                onDismissed: (direction) {
                  // Remove the member from the list
                  // setState(() {
                  //   members.removeAt(index);
                  // });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${member.value} removed'),
                    ),
                  );
                },
                confirmDismiss: (direction) async {
                  // Show a confirmation dialog before removing the member
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Remove Member'),
                        content: Text('Do you want to remove ${member.value}?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text('Remove'),
                          ),
                        ],
                      );
                    },
                  );
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Pallete.secondaryColor),
                    ),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        member.value[0],
                      ),
                    ),
                    title: Text(member.value),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Implement logic to add a member to the group
              // For example:
              // setState(() {
              //   members.add('New Member');
              // });
            },
            icon: Icon(Icons.add),
            label: Text(
              'Add Member to Group',
              style: TextStyle(
                color: Pallete.textColor,
              ),
            ),
            style: ButtonStyle(
              iconColor: MaterialStateProperty.all<Color>(Pallete.textColor),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Pallete.buttonPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
