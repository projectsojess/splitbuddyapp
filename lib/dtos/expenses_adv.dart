// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:splitbuddy/dtos/expense_payee.dart';
import 'package:splitbuddy/dtos/expense_payer.dart';
import 'package:splitbuddy/dtos/items.dart';

class ExpensesAdv {
  final String type;
  final int? expenseId;
  final int? createdById;
  final String? createdByName;
  final String date;
  final int payerId;
  final int? userToFriendId;
  final String description;
  final int? groupId;
  final List<Item>? items;
  final ExpensePayer? payer;
  final List<ExpensePayee>? payee;
  double? tax;
  double? serviceCharge;
  double? untaxedAmount;
  double? totalAmount;

  ExpensesAdv({
    this.payee,
    this.payer,
    this.expenseId,
    this.createdById,
    required this.type,
    this.createdByName,
    required this.payerId,
    required this.date,
    this.userToFriendId,
    required this.description,
    this.groupId,
    this.items,
    this.tax,
    this.serviceCharge,
    this.untaxedAmount,
    this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date,
      'payerId': payerId,
      'description': description,
      'type': type,
    };
    if (userToFriendId != 0) {
      map['userToFriendId'] = userToFriendId;
    }
    if (groupId != 0) {
      map['groupId'] = groupId;
    }
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

    if (items!.isNotEmpty) {
      map['items'] = items!.map((e) => e.toMap()).toList();
    }
    if (createdById != 0) {
      map['createdById'] = createdById;
    }
    return map;
  }

  factory ExpensesAdv.fromMap(Map<String, dynamic> map) {
    return ExpensesAdv(
      type: map['type'] as String,
      expenseId: map['expenseId'] != null ? map['expenseId'] as int : null,
      createdById: map['createdById'] != null ? map['createdById'] as int : 0,
      createdByName:
          map['createdByName'] != null ? map['createdByName'] as String : null,
      date: map['date'] as String,
      payerId: map['payerId'] as int,
      userToFriendId: map['userToFriendId'] as int,
      description: map['description'] as String,
      groupId: map['groupId'] != null ? map['groupId'] as int : null,
      items: map['items'] != null
          ? List<Item>.from(
              (map['items'] as List<int>).map<Item?>(
                (x) => Item.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      payer: map['payer'] != null
          ? ExpensePayer.fromMap(map['payer'] as Map<String, dynamic>)
          : null,
      payee: map['payee'] != null
          ? List<ExpensePayee>.from(
              (map['payee'] as List<int>).map<ExpensePayee?>(
                (x) => ExpensePayee.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      tax: map['tax'] != null ? map['tax'] as double : null,
      serviceCharge:
          map['serviceCharge'] != null ? map['serviceCharge'] as double : null,
      untaxedAmount:
          map['untaxedAmount'] != null ? map['untaxedAmount'] as double : null,
      totalAmount:
          map['totalAmount'] != null ? map['totalAmount'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpensesAdv.fromJson(String source) =>
      ExpensesAdv.fromMap(json.decode(source) as Map<String, dynamic>);
}
