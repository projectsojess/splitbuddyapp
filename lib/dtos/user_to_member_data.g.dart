// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_to_member_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserToMemberDataAdapter extends TypeAdapter<UserToMemberData> {
  @override
  final int typeId = 6;

  @override
  UserToMemberData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserToMemberData(
      memberId: fields[0] as int,
      memberName: fields[1] as String,
      amountOwedToUser: fields[2] as double,
      amountLentToUser: fields[3] as double,
      amountOwedInGroup: fields[4] as double,
      amountLentInGroup: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, UserToMemberData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.memberId)
      ..writeByte(1)
      ..write(obj.memberName)
      ..writeByte(2)
      ..write(obj.amountOwedToUser)
      ..writeByte(3)
      ..write(obj.amountLentToUser)
      ..writeByte(4)
      ..write(obj.amountOwedInGroup)
      ..writeByte(5)
      ..write(obj.amountLentInGroup);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserToMemberDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToMemberData _$UserToMemberDataFromJson(Map<String, dynamic> json) =>
    UserToMemberData(
      memberId: json['memberId'] as int,
      memberName: json['memberName'] as String,
      amountOwedToUser: (json['amountOwedToUser'] as num).toDouble(),
      amountLentToUser: (json['amountLentToUser'] as num).toDouble(),
      amountOwedInGroup: (json['amountOwedInGroup'] as num).toDouble(),
      amountLentInGroup: (json['amountLentInGroup'] as num).toDouble(),
    );

Map<String, dynamic> _$UserToMemberDataToJson(UserToMemberData instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'memberName': instance.memberName,
      'amountOwedToUser': instance.amountOwedToUser,
      'amountLentToUser': instance.amountLentToUser,
      'amountOwedInGroup': instance.amountOwedInGroup,
      'amountLentInGroup': instance.amountLentInGroup,
    };
