import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(includeIfNull: false)
class LoginResponse {
  final int userId;
  final String username;
  final String currency;
  final String displayCurrency;
  final String country;
  final String email;
  final String token;
  String? phone;
  bool? isSubscribed;
  String? subscriptionType;
  LoginResponse(
      {required this.userId,
      required this.username,
      required this.email,
      required this.token,
      required this.country,
      required this.currency,
      required this.displayCurrency,
      this.phone,
      this.isSubscribed,
      this.subscriptionType});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
