// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_payer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpensePayerAdapter extends TypeAdapter<ExpensePayer> {
  @override
  final int typeId = 1;

  @override
  ExpensePayer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpensePayer(
      share: fields[4] as double,
      payerId: fields[0] as int,
      expenseId: fields[1] as int,
      payerName: fields[2] as String,
      payedAmount: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ExpensePayer obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.payerId)
      ..writeByte(1)
      ..write(obj.expenseId)
      ..writeByte(2)
      ..write(obj.payerName)
      ..writeByte(3)
      ..write(obj.payedAmount)
      ..writeByte(4)
      ..write(obj.share);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpensePayerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
