// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_payee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpensePayee _$ExpensePayeeFromJson(Map<String, dynamic> json) => ExpensePayee(
      expenseId: json['expenseId'] as int,
      payeeId: json['payeeId'] as int,
      payeeName: json['payeeName'] as String,
      share: (json['share'] as num).toDouble(),
    );

Map<String, dynamic> _$ExpensePayeeToJson(ExpensePayee instance) =>
    <String, dynamic>{
      'expenseId': instance.expenseId,
      'payeeId': instance.payeeId,
      'payeeName': instance.payeeName,
      'share': instance.share,
    };
