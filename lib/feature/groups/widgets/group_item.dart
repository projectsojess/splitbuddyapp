import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/group_data.dart';

class GroupItem extends StatelessWidget {
  final GroupData groupData;
  final VoidCallback onTap;

  const GroupItem({super.key, required this.groupData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
