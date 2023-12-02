// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Payee {
  final int payeeId;
  final String shareType;
  final double? shareValue;
  final int? totalShares;
  final double payeeShare;

  Payee(
      {required this.payeeId,
      required this.shareType,
      this.shareValue,
      required this.totalShares,
      required this.payeeShare});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'payeeId': payeeId,
      'shareType': shareType,
      'shareValue': shareValue,
      'totalShares': totalShares,
      'payeeShare': payeeShare,
    };
  }

  String toJson() => json.encode(toMap());
}
