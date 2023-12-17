import 'package:json_annotation/json_annotation.dart';

part 'expense_payer.g.dart';

@JsonSerializable(includeIfNull: false)
class ExpensePayer {
  final int payerId;
  final int expenseId;
  final String payerName;
  final double payedAmount;
  final double share;

  ExpensePayer({
    required this.share,
    required this.payerId,
    required this.expenseId,
    required this.payerName,
    required this.payedAmount,
  });

  factory ExpensePayer.fromJson(Map<String, dynamic> json) =>
      _$ExpensePayerFromJson(json);

  Map<String, dynamic> toJson() => _$ExpensePayerToJson(this);
}
