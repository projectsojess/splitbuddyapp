import 'package:json_annotation/json_annotation.dart';
import 'package:splitbuddy/dtos/expense_payee.dart';
import 'package:splitbuddy/dtos/expense_payer.dart';
import 'package:splitbuddy/dtos/items.dart';
part 'expense_data.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class ExpenseData {
  final int expenseId;
  final int? userToFriendId;
  final int? groupId;
  final int createdById;
  final String createdByName;
  DateTime date;
  String description;
  double? tax;
  double? untaxedAmount;
  double totalAmount;
  double? serviceCharge;
  ExpensePayer payer;
  List<Item>? items;
  List<ExpensePayee> payees;
  String type;
  String? category;
  double? totalShares;
  String? shareType;
  bool settled;

  ExpenseData({
    required this.expenseId,
    required this.userToFriendId,
    required this.groupId,
    required this.createdById,
    required this.createdByName,
    required this.date,
    required this.description,
    required this.tax,
    required this.untaxedAmount,
    required this.totalAmount,
    required this.serviceCharge,
    required this.payer,
    required this.items,
    required this.payees,
    required this.type,
    required this.category,
    required this.settled,
    required this.shareType,
    required this.totalShares,
  });

  factory ExpenseData.fromJson(Map<String, dynamic> json) =>
      _$ExpenseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseDataToJson(this);
}
