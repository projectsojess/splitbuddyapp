// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:splitbuddy/dtos/items.dart';
import 'package:splitbuddy/dtos/payer_payee.dart';

class Expense {
  final String date;
  final int userToFriendId;
  final String description;
  final List<PayerPayee> payerPayees;
  double? tax;
  double? serviceCharge;
  double? untaxedAmount;
  double? totalAmount;

  Expense({
    required this.userToFriendId,
    required this.date,
    required this.payerPayees,
    required this.description,
    this.tax,
    this.serviceCharge,
    this.untaxedAmount,
    this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'payerPayees': payerPayees.map((e) => e.toMap()).toList(),
      'date': date,
      'description': description,
      'userToFriendId': userToFriendId,
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
