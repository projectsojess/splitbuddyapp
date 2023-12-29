// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 2;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      name: fields[3] as String,
      amount: fields[4] as double,
      quantity: fields[2] as int,
      usersInvolved: (fields[5] as List?)?.cast<int?>(),
      shareType: fields[6] as String,
      shareValues: (fields[7] as Map?)?.cast<int, double>(),
      totalShares: fields[8] as double?,
      expenseId: fields[0] as int?,
      itemId: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.expenseId)
      ..writeByte(1)
      ..write(obj.itemId)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.amount)
      ..writeByte(5)
      ..write(obj.usersInvolved)
      ..writeByte(6)
      ..write(obj.shareType)
      ..writeByte(7)
      ..write(obj.shareValues)
      ..writeByte(8)
      ..write(obj.totalShares);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
