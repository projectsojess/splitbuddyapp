// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExpensePayee {
  final int expenseId;
  final int payeeId;
  final int payerId;
  final String payeeName;
  final String payerName;
  final double share;

  ExpensePayee(
      {required this.expenseId,
      required this.payeeId,
      required this.payerId,
      required this.payeeName,
      required this.payerName,
      required this.share});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'expenseId': expenseId,
      'payeeId': payeeId,
      'payerId': payerId,
      'payeeName': payeeName,
      'payerName': payerName,
      'share': share,
    };
  }

  factory ExpensePayee.fromMap(Map<String, dynamic> map) {
    return ExpensePayee(
      expenseId: map['expenseId'] as int,
      payeeId: map['payeeId'] as int,
      payerId: map['payerId'] as int,
      payeeName: map['payeeName'] as String,
      payerName: map['payerName'] as String,
      share: map['share'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpensePayee.fromJson(String source) =>
      ExpensePayee.fromMap(json.decode(source) as Map<String, dynamic>);
}
