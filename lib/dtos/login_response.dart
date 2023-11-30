import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginResponse {
  final int userId;
  final String username;
  final String email;
  final String token;
  String? phone;
  LoginResponse({
    required this.userId,
    required this.username,
    required this.email,
    required this.token,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'username': username,
      'email': email,
      'token': token,
      'phone': phone,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      userId: map['userId'] as int,
      username: map['username'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
      phone: map['phone'] != null ? map['phone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
