// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Expense {
  int? expenseId;
  final int paidBy;
  final List<int> payee;
  final String type;
  final DateTime date;
  final String description;
  final Map<int, double> shares;
  Map<int, double>? shareDistribution;
  int? totalShares;
  double? tax;
  double? serviceCharge;
  double? untaxedAmount;
  double? totalAmount;

  Expense({
    required this.paidBy,
    required this.payee,
    required this.type,
    required this.date,
    required this.description,
    required this.shares,
    this.totalShares,
    this.tax,
    this.shareDistribution,
    this.serviceCharge,
    this.untaxedAmount,
    this.totalAmount,
    this.expenseId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'expenseId': expenseId,
      'paidBy': paidBy,
      'payee': payee,
      'type': type,
      'date': date.millisecondsSinceEpoch,
      'description': description,
      'shares': shares,
      'shareDistribution': shareDistribution,
      'totalShares': totalShares,
      'tax': tax,
      'serviceCharge': serviceCharge,
      'untaxedAmount': untaxedAmount,
      'totalAmount': totalAmount,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      expenseId: ['expenseId'] != null ? map['expenseId'] as int : null,
      paidBy: map['paidBy'] as int,
      payee: List<int>.from((map['payee'] as List<int>)),
      type: map['type'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      description: map['description'] as String,
      shares: Map<int, double>.from((map['shares'] as Map<int, double>)),
      shareDistribution: map['shareDistribution'] != null
          ? Map<int, double>.from(
              (map['shareDistribution'] as Map<int, double>))
          : null,
      totalShares:
          map['totalShares'] != null ? map['totalShares'] as int : null,
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

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source) as Map<String, dynamic>);
}
