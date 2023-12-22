// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:splitbuddy/dtos/expense_payee.dart';
import 'package:splitbuddy/dtos/expense_payer.dart';
import 'package:splitbuddy/dtos/items.dart';

part 'expenses_adv.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
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
  final double? totalAmount;

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
    required this.totalAmount,
  });
  factory ExpensesAdv.fromJson(Map<String, dynamic> json) =>
      _$ExpensesAdvFromJson(json);

  Map<String, dynamic> toJson() => _$ExpensesAdvToJson(this);
}
