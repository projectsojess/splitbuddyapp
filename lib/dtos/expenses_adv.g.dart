// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_adv.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpensesAdv _$ExpensesAdvFromJson(Map<String, dynamic> json) => ExpensesAdv(
      payee: (json['payee'] as List<dynamic>?)
          ?.map((e) => ExpensePayee.fromJson(e as Map<String, dynamic>))
          .toList(),
      payer: json['payer'] == null
          ? null
          : ExpensePayer.fromJson(json['payer'] as Map<String, dynamic>),
      expenseId: json['expenseId'] as int?,
      createdById: json['createdById'] as int?,
      type: json['type'] as String,
      createdByName: json['createdByName'] as String?,
      payerId: json['payerId'] as int,
      date: json['date'] as String,
      userToFriendId: json['userToFriendId'] as int?,
      description: json['description'] as String,
      groupId: json['groupId'] as int?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      tax: (json['tax'] as num?)?.toDouble(),
      serviceCharge: (json['serviceCharge'] as num?)?.toDouble(),
      untaxedAmount: (json['untaxedAmount'] as num?)?.toDouble(),
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ExpensesAdvToJson(ExpensesAdv instance) {
  final val = <String, dynamic>{
    'type': instance.type,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('expenseId', instance.expenseId);
  writeNotNull('createdById', instance.createdById);
  writeNotNull('createdByName', instance.createdByName);
  val['date'] = instance.date;
  val['payerId'] = instance.payerId;
  writeNotNull('userToFriendId', instance.userToFriendId);
  val['description'] = instance.description;
  writeNotNull('groupId', instance.groupId);
  writeNotNull('items', instance.items?.map((e) => e.toJson()).toList());
  writeNotNull('payer', instance.payer?.toJson());
  writeNotNull('payee', instance.payee?.map((e) => e.toJson()).toList());
  writeNotNull('tax', instance.tax);
  writeNotNull('serviceCharge', instance.serviceCharge);
  writeNotNull('untaxedAmount', instance.untaxedAmount);
  writeNotNull('totalAmount', instance.totalAmount);
  return val;
}
