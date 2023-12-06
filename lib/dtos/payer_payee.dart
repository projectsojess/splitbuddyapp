// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PayerPayee {
  final int id;
  final String type;
  final String shareType;
  final double? shareValue;
  final double? payedAmount;
  final int? totalShares;
  final double share;

  PayerPayee(
      {required this.id,
      required this.type,
      required this.shareType,
      this.payedAmount,
      this.shareValue,
      required this.totalShares,
      required this.share});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'shareType': shareType,
      'shareValue': shareValue,
      'totalShares': totalShares,
      'share': share,
      'payedAmount': payedAmount,
    };
  }

  String toJson() => json.encode(toMap());
}
