import 'package:json_annotation/json_annotation.dart';
import 'package:splitbuddy/dtos/country_data.dart';
part 'country_response.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class CountryResponse {
  final List<CountryData> countries;

  CountryResponse({required this.countries});

  factory CountryResponse.fromJson(Map<String, dynamic> json) =>
      _$CountryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CountryResponseToJson(this);
}
