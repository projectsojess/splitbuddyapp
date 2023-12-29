// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_payee.g.dart';

@JsonSerializable(includeIfNull: false)
@HiveType(typeId: 3)
class ExpensePayee extends HiveObject {
  @HiveField(0)
  final int expenseId;

  @HiveField(1)
  final int payeeId;

  @HiveField(2)
  final String payeeName;

  @HiveField(3)
  final double share;

  ExpensePayee(
      {required this.expenseId,
      required this.payeeId,
      required this.payeeName,
      required this.share});

  factory ExpensePayee.fromJson(Map<String, dynamic> json) =>
      _$ExpensePayeeFromJson(json);

  Map<String, dynamic> toJson() => _$ExpensePayeeToJson(this);
}
