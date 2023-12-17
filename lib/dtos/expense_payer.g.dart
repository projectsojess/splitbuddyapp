// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_payer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpensePayer _$ExpensePayerFromJson(Map<String, dynamic> json) => ExpensePayer(
      share: (json['share'] as num).toDouble(),
      payerId: json['payerId'] as int,
      expenseId: json['expenseId'] as int,
      payerName: json['payerName'] as String,
      payedAmount: (json['payedAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$ExpensePayerToJson(ExpensePayer instance) =>
    <String, dynamic>{
      'payerId': instance.payerId,
      'expenseId': instance.expenseId,
      'payerName': instance.payerName,
      'payedAmount': instance.payedAmount,
      'share': instance.share,
    };
