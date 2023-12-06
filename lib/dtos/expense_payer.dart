// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart';

class ExpensePayer {
  final int payerId;
  final int expenseId;
  final String payerName;
  final double payedAmount;
  final String shareType;
  final double? shareValue;
  final int? totalShares;
  final double share;

  ExpensePayer({
    required this.shareType,
    this.shareValue,
    this.totalShares,
    required this.share,
    required this.payerId,
    required this.expenseId,
    required this.payerName,
    required this.payedAmount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'payerId': payerId,
      'expenseId': expenseId,
      'payerName': payerName,
      'payedAmount': payedAmount,
      'share': share,
    };
  }

  factory ExpensePayer.fromMap(Map<String, dynamic> map) {
    return ExpensePayer(
      payerId: map['payerId'] as int,
      expenseId: map['expenseId'] as int,
      payerName: map['payerName'] as String,
      payedAmount: map['payedAmount'] as double,
      shareType: map['shareType'] as String,
      shareValue:
          map['shareValue'] != null ? map['shareValue'] as double : null,
      totalShares:
          map['totalShares'] != null ? map['totalShares'] as int : null,
      share: map['share'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpensePayer.fromJson(String source) =>
      ExpensePayer.fromMap(json.decode(source) as Map<String, dynamic>);
}
