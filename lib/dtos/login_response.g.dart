// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginResponseAdapter extends TypeAdapter<LoginResponse> {
  @override
  final int typeId = 4;

  @override
  LoginResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginResponse(
      userId: fields[0] as int,
      username: fields[1] as String,
      email: fields[5] as String,
      token: fields[6] as String,
      country: fields[4] as String,
      currency: fields[2] as String,
      phone: fields[7] as String?,
      isSubscribed: fields[8] as bool?,
      subscriptionType: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginResponse obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.currency)
      ..writeByte(4)
      ..write(obj.country)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.token)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.isSubscribed)
      ..writeByte(9)
      ..write(obj.subscriptionType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      userId: json['userId'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
      country: json['country'] as String,
      currency: json['currency'] as String,
      phone: json['phone'] as String?,
      isSubscribed: json['isSubscribed'] as bool?,
      subscriptionType: json['subscriptionType'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) {
  final val = <String, dynamic>{
    'userId': instance.userId,
    'username': instance.username,
    'currency': instance.currency,
    'country': instance.country,
    'email': instance.email,
    'token': instance.token,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('phone', instance.phone);
  writeNotNull('isSubscribed', instance.isSubscribed);
  writeNotNull('subscriptionType', instance.subscriptionType);
  return val;
}
