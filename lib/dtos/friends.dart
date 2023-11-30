import 'package:flutter/material.dart';

class Friend {
  final int userId;
  final IconData icon;
  final String name;
  final double amount;

  Friend(
      {required this.userId,
      required this.icon,
      required this.name,
      required this.amount});
}
