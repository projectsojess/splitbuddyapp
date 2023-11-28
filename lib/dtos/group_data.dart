import 'package:flutter/material.dart';

class GroupData {
  final String name;
  final IconData icon;
  final double amount;
  final int groupId;

  GroupData(
      {required this.name,
      required this.icon,
      required this.amount,
      required this.groupId});
}
