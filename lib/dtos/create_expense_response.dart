// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:splitbuddy/dtos/expense_payee.dart';
import 'package:splitbuddy/dtos/expense_payer.dart';

class CreateExpenseResponse {
  final int expenseId;
  final int? userToFriendId;
  final int? groupId;
  final int userId;
  final String createdBy;
  final DateTime date;
  final String description;
  final double? tax;
  final double? untaxedAmount;
  final double totalAmount;
  final ExpensePayer? payer;
  final List<ExpensePayee>? payees;

  CreateExpenseResponse(
      {required this.expenseId,
      this.groupId,
      this.userToFriendId,
      required this.userId,
      required this.createdBy,
      required this.date,
      required this.description,
      this.tax,
      this.untaxedAmount,
      required this.totalAmount,
      this.payer,
      this.payees});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'expenseId': expenseId,
      'groupId': groupId,
      'userToFriendId': userToFriendId,
      'userId': userId,
      'createdBy': createdBy,
      'date': date.toIso8601String(),
      'description': description,
      'tax': tax,
      'untaxedAmount': untaxedAmount,
      'totalAmount': totalAmount,
    };
  }

  factory CreateExpenseResponse.fromMap(Map<String, dynamic> map) {
    return CreateExpenseResponse(
      expenseId: map['expenseId'] as int,
      groupId: map['groupId'] != null ? map['groupId'] as int : 0,
      userToFriendId:
          map['userToFriendId'] != null ? map['userToFriendId'] as int : 0,
      userId: map['userId'] as int,
      createdBy: map['createdBy'] as String,
      date: DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(map['date']),
      description: map['description'] as String,
      tax: map['tax'] != null ? map['tax'] as double : null,
      untaxedAmount:
          map['untaxedAmount'] != null ? map['untaxedAmount'] as double : null,
      totalAmount: map['totalAmount'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateExpenseResponse.fromJson(String source) =>
      CreateExpenseResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);

  static List<CreateExpenseResponse> expensesFriendsListFromJson(
      String response) {
    final parsed =
        json.decode(response)['userToFriends'].cast<Map<String, dynamic>>();

    return parsed
        .map<CreateExpenseResponse>(
            (json) => CreateExpenseResponse.fromMap(json))
        .toList();
  }

  static List<CreateExpenseResponse> expensesGroupsListFromJson(
      String response) {
    final parsed =
        json.decode(response)['userToGroups'].cast<Map<String, dynamic>>();

    return parsed
        .map<CreateExpenseResponse>(
            (json) => CreateExpenseResponse.fromMap(json))
        .toList();
  }
}
