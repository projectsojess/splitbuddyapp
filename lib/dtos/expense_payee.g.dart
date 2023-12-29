// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_payee.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpensePayeeAdapter extends TypeAdapter<ExpensePayee> {
  @override
  final int typeId = 3;

  @override
  ExpensePayee read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpensePayee(
      expenseId: fields[0] as int,
      payeeId: fields[1] as int,
      payeeName: fields[2] as String,
      share: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ExpensePayee obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.expenseId)
      ..writeByte(1)
      ..write(obj.payeeId)
      ..writeByte(2)
      ..write(obj.payeeName)
      ..writeByte(3)
      ..write(obj.share);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpensePayeeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
