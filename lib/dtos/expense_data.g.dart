// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseDataAdapter extends TypeAdapter<ExpenseData> {
  @override
  final int typeId = 0;

  @override
  ExpenseData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseData(
      expenseId: fields[0] as int,
      userToFriendId: fields[1] as int?,
      groupId: fields[2] as int?,
      createdById: fields[3] as int,
      createdByName: fields[4] as String,
      date: fields[5] as DateTime,
      description: fields[6] as String,
      tax: fields[7] as double?,
      untaxedAmount: fields[8] as double?,
      totalAmount: fields[9] as double,
      serviceCharge: fields[10] as double?,
      payer: fields[11] as ExpensePayer,
      items: (fields[12] as List?)?.cast<Item>(),
      payees: (fields[13] as List).cast<ExpensePayee>(),
      type: fields[14] as String,
      category: fields[15] as String?,
      settled: fields[18] as bool,
      shareType: fields[17] as String?,
      totalShares: fields[16] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseData obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.expenseId)
      ..writeByte(1)
      ..write(obj.userToFriendId)
      ..writeByte(2)
      ..write(obj.groupId)
      ..writeByte(3)
      ..write(obj.createdById)
      ..writeByte(4)
      ..write(obj.createdByName)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.tax)
      ..writeByte(8)
      ..write(obj.untaxedAmount)
      ..writeByte(9)
      ..write(obj.totalAmount)
      ..writeByte(10)
      ..write(obj.serviceCharge)
      ..writeByte(11)
      ..write(obj.payer)
      ..writeByte(12)
      ..write(obj.items)
      ..writeByte(13)
      ..write(obj.payees)
      ..writeByte(14)
      ..write(obj.type)
      ..writeByte(15)
      ..write(obj.category)
      ..writeByte(16)
      ..write(obj.totalShares)
      ..writeByte(17)
      ..write(obj.shareType)
      ..writeByte(18)
      ..write(obj.settled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
