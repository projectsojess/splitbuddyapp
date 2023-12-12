import 'package:flutter/material.dart';

class GroupData {
  String name;
  String category;
  String type;
  List<int> users;
  GroupData(
      {required this.name,
      required this.category,
      required this.users,
      required this.type});
}
