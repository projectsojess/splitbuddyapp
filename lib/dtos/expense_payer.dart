import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_payer.g.dart';

@JsonSerializable(includeIfNull: false)
@HiveType(typeId: 1)
class ExpensePayer extends HiveObject {
  @HiveField(0)
  final int payerId;

  @HiveField(1)
  final int expenseId;

  @HiveField(2)
  final String payerName;

  @HiveField(3)
  final double payedAmount;

  @HiveField(4)
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
