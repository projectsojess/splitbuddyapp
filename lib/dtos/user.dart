import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String userId;
  final String username;
  final String email;
  final String token;
  final String password;
  String? phone;

  User(
      {required this.userId,
      required this.username,
      required this.email,
      required this.token,
      required this.password,
      this.phone});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'username': username,
      'email': email,
      'password': password,
    };

    // Only add non-empty values to the map for serialization
    if (userId.isNotEmpty) {
      map['userId'] = userId;
    }
    if (token.isNotEmpty) {
      map['token'] = token;
    }
    if (phone != null && phone!.isNotEmpty) {
      map['phone'] = phone!;
    }

    return map;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
      password: map['password'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
