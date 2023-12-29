// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupDataAdapter extends TypeAdapter<GroupData> {
  @override
  final int typeId = 5;

  @override
  GroupData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupData(
      groupId: fields[0] as int,
      groupName: fields[1] as String,
      members: (fields[2] as Map).cast<int, String>(),
      amountBorrowed: fields[3] as double,
      amountLent: fields[4] as double,
      type: fields[5] as String,
      category: fields[7] as String,
      memberData: (fields[6] as List).cast<UserToMemberData>(),
      createdDate: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, GroupData obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.groupId)
      ..writeByte(1)
      ..write(obj.groupName)
      ..writeByte(2)
      ..write(obj.members)
      ..writeByte(3)
      ..write(obj.amountBorrowed)
      ..writeByte(4)
      ..write(obj.amountLent)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.memberData)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.createdDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupData _$GroupDataFromJson(Map<String, dynamic> json) => GroupData(
      groupId: json['groupId'] as int,
      groupName: json['groupName'] as String,
      members: (json['members'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as String),
      ),
      amountBorrowed: (json['amountBorrowed'] as num).toDouble(),
      amountLent: (json['amountLent'] as num).toDouble(),
      type: json['type'] as String,
      category: json['category'] as String,
      memberData: (json['memberData'] as List<dynamic>)
          .map((e) => UserToMemberData.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdDate: DateTime.parse(json['createdDate'] as String),
    );

Map<String, dynamic> _$GroupDataToJson(GroupData instance) => <String, dynamic>{
      'groupId': instance.groupId,
      'groupName': instance.groupName,
      'members': instance.members.map((k, e) => MapEntry(k.toString(), e)),
      'amountBorrowed': instance.amountBorrowed,
      'amountLent': instance.amountLent,
      'type': instance.type,
      'memberData': instance.memberData,
      'category': instance.category,
      'createdDate': instance.createdDate.toIso8601String(),
    };
