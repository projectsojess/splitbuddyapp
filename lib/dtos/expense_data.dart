import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:splitbuddy/dtos/expense_payee.dart';
import 'package:splitbuddy/dtos/expense_payer.dart';
import 'package:splitbuddy/dtos/items.dart';
part 'expense_data.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
@HiveType(typeId: 0)
class ExpenseData extends HiveObject {
  @HiveField(0)
  final int expenseId;

  @HiveField(1)
  final int? userToFriendId;

  @HiveField(2)
  final int? groupId;

  @HiveField(3)
  final int createdById;

  @HiveField(4)
  final String createdByName;

  @HiveField(5)
  DateTime date;

  @HiveField(6)
  String description;

  @HiveField(7)
  double? tax;

  @HiveField(8)
  double? untaxedAmount;

  @HiveField(9)
  double totalAmount;

  @HiveField(10)
  double? serviceCharge;

  @HiveField(11)
  ExpensePayer payer;

  @HiveField(12)
  List<Item>? items;

  @HiveField(13)
  List<ExpensePayee> payees;

  @HiveField(14)
  String type;

  @HiveField(15)
  String? category;

  @HiveField(16)
  double? totalShares;

  @HiveField(17)
  String? shareType;

  @HiveField(18)
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
