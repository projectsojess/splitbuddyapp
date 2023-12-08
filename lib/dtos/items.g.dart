// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      quantity: json['quantity'] as int,
      usersInvolved: (json['usersInvolved'] as List<dynamic>?)
          ?.map((e) => e as int?)
          .toList(),
      shareType: json['shareType'] as String,
      shareValues: (json['shareValues'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(int.parse(k), (e as num).toDouble()),
      ),
      totalShares: (json['totalShares'] as num?)?.toDouble(),
      expenseId: json['expenseId'] as int?,
      itemId: json['itemId'] as int?,
    );

Map<String, dynamic> _$ItemToJson(Item instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('expenseId', instance.expenseId);
  writeNotNull('itemId', instance.itemId);
  val['quantity'] = instance.quantity;
  val['name'] = instance.name;
  val['amount'] = instance.amount;
  writeNotNull('usersInvolved', instance.usersInvolved);
  val['shareType'] = instance.shareType;
  writeNotNull('shareValues',
      instance.shareValues?.map((k, e) => MapEntry(k.toString(), e)));
  writeNotNull('totalShares', instance.totalShares);
  return val;
}
