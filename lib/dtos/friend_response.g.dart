// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FriendResponseAdapter extends TypeAdapter<FriendResponse> {
  @override
  final int typeId = 7;

  @override
  FriendResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FriendResponse(
      userToFriendId: fields[0] as int,
      userId: fields[1] as int,
      friendId: fields[2] as int,
      icon: fields[3] as String,
      name: fields[4] as String,
      amountLentToFriend: fields[6] as double,
      amountOwedToFriend: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, FriendResponse obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.userToFriendId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.friendId)
      ..writeByte(3)
      ..write(obj.icon)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.amountOwedToFriend)
      ..writeByte(6)
      ..write(obj.amountLentToFriend);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FriendResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendResponse _$FriendResponseFromJson(Map<String, dynamic> json) =>
    FriendResponse(
      userToFriendId: json['userToFriendId'] as int,
      userId: json['userId'] as int,
      friendId: json['friendId'] as int,
      icon: json['icon'] as String,
      name: json['name'] as String,
      amountLentToFriend: (json['amountLentToFriend'] as num).toDouble(),
      amountOwedToFriend: (json['amountOwedToFriend'] as num).toDouble(),
    );

Map<String, dynamic> _$FriendResponseToJson(FriendResponse instance) =>
    <String, dynamic>{
      'userToFriendId': instance.userToFriendId,
      'userId': instance.userId,
      'friendId': instance.friendId,
      'icon': instance.icon,
      'name': instance.name,
      'amountOwedToFriend': instance.amountOwedToFriend,
      'amountLentToFriend': instance.amountLentToFriend,
    };
