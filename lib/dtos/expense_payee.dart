// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'expense_payee.g.dart';

@JsonSerializable(includeIfNull: false)
class ExpensePayee {
  final int expenseId;
  final int payeeId;
  final String payeeName;
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
