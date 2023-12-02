// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:splitbuddy/dtos/payee.dart';

class Expense {
  final int paidBy;
  final String date;
  final String description;
  final List<Payee> payees;
  double? tax;
  double? serviceCharge;
  double? untaxedAmount;
  double? totalAmount;

  Expense({
    required this.paidBy,
    required this.date,
    required this.payees,
    required this.description,
    this.tax,
    this.serviceCharge,
    this.untaxedAmount,
    this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'paidBy': paidBy,
      'payees': payees.map((e) => e.toMap()).toList(),
      'date': date,
      'description': description,
    };
    if (tax != 0) {
      map['tax'] = tax;
    }
    if (serviceCharge != 0) {
      map['serviceCharge'] = serviceCharge;
    }
    if (untaxedAmount != 0) {
      map['untaxedAmount'] = untaxedAmount;
    }
    if (totalAmount != 0) {
      map['totalAmount'] = totalAmount;
    }
    return map;
  }

  String toJson() => json.encode(toMap());
}
