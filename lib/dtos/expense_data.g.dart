// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseData _$ExpenseDataFromJson(Map<String, dynamic> json) => ExpenseData(
      expenseId: json['expenseId'] as int,
      userToFriendId: json['userToFriendId'] as int?,
      groupId: json['groupId'] as int?,
      createdById: json['createdById'] as int,
      createdByName: json['createdByName'] as String,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String,
      tax: (json['tax'] as num?)?.toDouble(),
      untaxedAmount: (json['untaxedAmount'] as num?)?.toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      serviceCharge: (json['serviceCharge'] as num?)?.toDouble(),
      payer: ExpensePayer.fromJson(json['payer'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      payees: (json['payees'] as List<dynamic>)
          .map((e) => ExpensePayee.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String,
      category: json['category'] as String?,
      settled: json['settled'] as bool,
      shareType: json['shareType'] as String?,
      totalShares: (json['totalShares'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ExpenseDataToJson(ExpenseData instance) {
  final val = <String, dynamic>{
    'expenseId': instance.expenseId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userToFriendId', instance.userToFriendId);
  writeNotNull('groupId', instance.groupId);
  val['createdById'] = instance.createdById;
  val['createdByName'] = instance.createdByName;
  val['date'] = instance.date.toIso8601String();
  val['description'] = instance.description;
  writeNotNull('tax', instance.tax);
  writeNotNull('untaxedAmount', instance.untaxedAmount);
  val['totalAmount'] = instance.totalAmount;
  writeNotNull('serviceCharge', instance.serviceCharge);
  val['payer'] = instance.payer.toJson();
  writeNotNull('items', instance.items?.map((e) => e.toJson()).toList());
  val['payees'] = instance.payees.map((e) => e.toJson()).toList();
  val['type'] = instance.type;
  writeNotNull('category', instance.category);
  writeNotNull('totalShares', instance.totalShares);
  writeNotNull('shareType', instance.shareType);
  val['settled'] = instance.settled;
  return val;
}
