// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:splitbuddy/dtos/item_sharers.dart';

class Item {
  final int? expenseId;
  final int? itemId;
  String name;
  double amount;
  List<int?>? usersInvolved;
  String shareType;
  Map<int, double>? shareValue;
  double? totalShares;
  final List<ItemSharer>? itemSharers;

  Item(
      {required this.name,
      required this.amount,
      required this.usersInvolved,
      required this.shareType,
      required this.shareValue,
      this.itemSharers,
      required this.totalShares,
      this.expenseId,
      this.itemId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'expenseId': expenseId,
      'itemId': itemId,
      'name': name,
      'amount': amount,
      'usersInvolved': usersInvolved,
      'shareType': shareType,
      'shareValue': shareValue,
      'totalShares': totalShares,
      'itemSharers': itemSharers!.map((x) => x?.toMap()).toList(),
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
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
      itemSharers: map['itemSharers'] != null
          ? (map['itemSharers'] as List<dynamic>?)
              ?.map((sharer) => ItemSharer.fromJson(sharer))
              .toList()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);
}
