// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

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
      displayCurrency: json['displayCurrency'] as String,
      phone: json['phone'] as String?,
      isSubscribed: json['isSubscribed'] as bool?,
      subscriptionType: json['subscriptionType'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) {
  final val = <String, dynamic>{
    'userId': instance.userId,
    'username': instance.username,
    'currency': instance.currency,
    'displayCurrency': instance.displayCurrency,
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
