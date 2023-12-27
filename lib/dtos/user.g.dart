// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: json['userId'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
      password: json['password'] as String,
      currency: json['currency'] as String,
      country: json['country'] as String,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{
    'userId': instance.userId,
    'username': instance.username,
    'email': instance.email,
    'token': instance.token,
    'password': instance.password,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('phone', instance.phone);
  val['currency'] = instance.currency;
  val['country'] = instance.country;
  return val;
}
