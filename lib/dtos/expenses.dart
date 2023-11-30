import 'package:flutter/material.dart';

class Expense {
  final DateTime date;
  final String category;
  final String name;
  final double amount;
  final bool isOwed;

  Expense({
    required this.date,
    required this.category,
    required this.name,
    required this.amount,
    required this.isOwed,
  });
}
