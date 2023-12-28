// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryData _$CountryDataFromJson(Map<String, dynamic> json) => CountryData(
      name: json['name'] as String,
      code: json['code'] as String,
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$CountryDataToJson(CountryData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'currency': instance.currency,
    };
