import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(includeIfNull: false)
class User {
  final int userId;
  String username;
  String email;
  final String token;
  String password;
  String? phone;
  String currency;
  String country;
  String? image;

  User(
      {required this.userId,
      required this.username,
      required this.email,
      required this.token,
      required this.password,
      required this.currency,
      required this.country,
      this.image,
      this.phone});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
