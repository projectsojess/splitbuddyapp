// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart';

class Item {
  final int? expenseId;
  final int? itemId;
  int quantity;
  String name;
  double amount;
  List<int?>? usersInvolved;
  String shareType;
  Map<int, double>? shareValue;
  double? totalShares;

  Item(
      {required this.name,
      required this.amount,
      required this.quantity,
      required this.usersInvolved,
      required this.shareType,
      this.shareValue,
      this.totalShares,
      this.expenseId,
      this.itemId});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'amount': amount,
      'usersInvolved': usersInvolved,
      'shareType': shareType,
      'quantity': quantity,
    };
    if (shareValue!.isNotEmpty) {
      map['shareValue'] = shareValue;
    }
    return map;
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      quantity: map['quantity'],
      expenseId: map['expenseId'] != null ? map['expenseId'] as int : null,
      itemId: map['itemId'] != null ? map['itemId'] as int : null,
      name: map['name'] as String,
      amount: map['amount'] as double,
      usersInvolved: map['usersInvolved'] != null
          ? List<int?>.from((map['usersInvolved']?.cast<int?>()?.toList()))
          : null,
      shareType: map['shareType'] as String,
      shareValue: map['shareValue'] != null
          ? Map<int, double>.from((map['shareValue'] as Map<int, double>))
          : null,
      totalShares:
          map['totalShares'] != null ? map['totalShares'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);
}
