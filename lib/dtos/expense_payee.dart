// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExpensePayee {
  final int expenseId;
  final int payeeId;
  final int payerId;
  final String payeeName;
  final String shareType;
  final double? shareValue;
  final int? totalShares;
  final double payeeShare;

  ExpensePayee(
      {required this.expenseId,
      required this.payeeId,
      required this.payerId,
      required this.payeeName,
      required this.shareType,
      this.shareValue,
      this.totalShares,
      required this.payeeShare});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'expenseId': expenseId,
      'payeeId': payeeId,
      'payerId': payerId,
      'payeeName': payeeName,
      'shareType': shareType,
      'shareValue': shareValue,
      'totalShares': totalShares,
      'payeeShare': payeeShare,
    };
  }

  factory ExpensePayee.fromMap(Map<String, dynamic> map) {
    return ExpensePayee(
      expenseId: map['expenseId'] as int,
      payeeId: map['payeeId'] as int,
      payerId: map['payerId'] as int,
      payeeName: map['payeeName'] as String,
      shareType: map['shareType'] as String,
      shareValue:
          map['shareValue'] != null ? map['shareValue'] as double : null,
      totalShares:
          map['totalShares'] != null ? map['totalShares'] as int : null,
      payeeShare: map['payeeShare'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpensePayee.fromJson(String source) =>
      ExpensePayee.fromMap(json.decode(source) as Map<String, dynamic>);
}
