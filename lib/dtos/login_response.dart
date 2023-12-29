import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@HiveType(typeId: 4)
@JsonSerializable(includeIfNull: false)
class LoginResponse {
  @HiveField(0)
  final int userId;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String currency;

  @HiveField(4)
  final String country;

  @HiveField(5)
  final String email;

  @HiveField(6)
  final String token;

  @HiveField(7)
  String? phone;

  @HiveField(8)
  bool? isSubscribed;

  @HiveField(9)
  String? subscriptionType;

  LoginResponse(
      {required this.userId,
      required this.username,
      required this.email,
      required this.token,
      required this.country,
      required this.currency,
      this.phone,
      this.isSubscribed,
      this.subscriptionType});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
