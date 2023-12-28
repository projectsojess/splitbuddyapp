import 'package:json_annotation/json_annotation.dart';
part 'country_data.g.dart';

@JsonSerializable(includeIfNull: false)
class CountryData {
  final String name;
  final String code;
  final String currency;

  CountryData({required this.name, required this.code, required this.currency});

  factory CountryData.fromJson(Map<String, dynamic> json) =>
      _$CountryDataFromJson(json);

  Map<String, dynamic> toJson() => _$CountryDataToJson(this);
}
