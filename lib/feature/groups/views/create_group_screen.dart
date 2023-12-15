import 'package:flutter/material.dart';
import 'package:splitbuddy/common/utils.dart';
import 'package:splitbuddy/dtos/create_group.dart';
import 'package:splitbuddy/feature/groups/views/add_friends_list.dart';
import 'package:splitbuddy/services/group_service.dart';
import 'package:splitbuddy/themes/pallete.dart';

class CreateGroupScreen extends StatefulWidget {
  final String type;

  static route({required String type}) =>
      MaterialPageRoute(builder: (context) => CreateGroupScreen(type: type));

  const CreateGroupScreen({super.key, required this.type});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  GroupService service = GroupService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<int, String> selectedUsersMap = {};
  CreateGroup groupData = CreateGroup(
      groupName: '',
      type: 'N',
      category: 'H',
      participants: []); // Variable to hold the selected category

  // List of categories (you can replace it with your own list of categories)
  Map<String, String> categories = {
    'H': 'House',
    'F': 'Friends',
    'W': 'Work',
    'P': 'Hostel/PG',
    'FM': 'Family',
  };

  Map<String, IconData> categoryIcons = {
    'H': Icons.home,
    'F': Icons.people_alt,
    'FM': Icons.family_restroom,
    'W': Icons.work,
    'P': Icons.hotel_sharp,
  };
  void createGroup() {
    service.createGroup(context: context, createGroup: groupData);
  }

  @override
  Widget build(BuildContext context) {
    bool isSelectedUsersEmpty = groupData.participants.isEmpty;
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text('Your Image Here'),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a group name';
                            }
                            return null;
                          },
                          decoration:
                              customInputFieldDecoration("", "Group name"),
                          cursorColor: Pallete.secondaryColor,
                          onChanged: (value) {
                            setState(() {
                              groupData.groupName = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.keys.map((category) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              groupData.category = category;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: groupData.category == category
                                    ? Pallete.secondaryColor
                                    : const Color.fromARGB(255, 29, 28, 28),
                              ),
                              color: groupData.category == category
                                  ? Pallete.secondaryColor
                                  : const Color.fromARGB(255, 29, 28, 28),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  categoryIcons[category],
                                  color: groupData.category == category
                                      ? Colors.white
                                      : Pallete.secondaryColor,
                                ),
                                SizedBox(width: 6.0),
                                Text(
                                  categories[category]!,
                                  style: TextStyle(
                                    color: groupData.category == category
                                        ? Colors.white
                                        : Pallete.secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (groupData.participants.isNotEmpty)
                    Row(
                      children: [
                        Text(
                          'Members',
                          style: TextStyle(color: Pallete.inputLabelTextColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ...groupData.participants
                            .map((userId) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      groupData.participants.remove(userId);
                                      selectedUsersMap.remove(userId);
                                    });
                                  },
                                  child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                          color: Pallete.secondaryColor,
                                        ),
                                        color: Pallete.secondaryColor,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            selectedUsersMap[userId]!,
                                            style: TextStyle(
                                              color:
                                                  Pallete.inputLabelTextColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            size: 15,
                                            Icons.clear,
                                            color: Pallete.inputLabelTextColor,
                                          ),
                                        ],
                                      )),
                                ))
                            .toList(),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Pallete.chipUnselectedColor),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final result = await Navigator.push(
                                    context,
                                    AddFriendsList.route(
                                        selectedUsers: selectedUsersMap));

                                if (result != null &&
                                    result is Map<int, String>) {
                                  setState(() {
                                    print(selectedUsersMap);
                                    selectedUsersMap = result;
                                    groupData.participants =
                                        List<int>.of(result.keys);
                                  });
                                }
                              }
                            },
                            icon: Icon(
                              Icons.add,
                              color: Pallete.secondaryColor,
                            ),
                            label: Text(
                              'Add',
                              style: TextStyle(
                                color: Pallete.secondaryColor,
                              ),
                            ))
                      ],
                    ),
                  SizedBox(
                    height: 50,
                  ),
                  isSelectedUsersEmpty
                      ? ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final result = await Navigator.push(
                                  context,
                                  AddFriendsList.route(
                                      selectedUsers: selectedUsersMap));

                              if (result != null &&
                                  result is Map<int, String>) {
                                setState(() {
                                  selectedUsersMap = result;
                                  print(selectedUsersMap);
                                  groupData.participants =
                                      List<int>.of(result.keys);
                                });
                              }
                            }
                          },
                          label: Text(
                            'Next',
                            style:
                                TextStyle(color: Pallete.inputLabelTextColor),
                          ),
                          icon: Icon(
                            Icons.navigate_next,
                            color: Pallete.inputLabelTextColor,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Pallete.secondaryColor),
                        )
                      : ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              createGroup();
                            }
                          },
                          label: Text(
                            'Create group',
                            style:
                                TextStyle(color: Pallete.inputLabelTextColor),
                          ),
                          icon: Icon(
                            Icons.add,
                            color: Pallete.inputLabelTextColor,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Pallete.secondaryColor),
                        ),
                ],
              ),
            ),
          )),
    );
  }
}
