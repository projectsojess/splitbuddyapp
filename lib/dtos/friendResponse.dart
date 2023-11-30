// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FriendResponse {
  final int userToFriendId;
  final String icon;
  final String name;
  final double amount;

  FriendResponse(
      {required this.userToFriendId,
      required this.icon,
      required this.name,
      required this.amount});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userToFriendId': userToFriendId,
      'icon': icon,
      'name': name,
      'amount': amount,
    };
  }

  factory FriendResponse.fromMap(Map<String, dynamic> map) {
    dynamic amountValue = map['amount'];
    double parsedAmount =
        amountValue is int ? amountValue.toDouble() : amountValue as double;
    return FriendResponse(
      userToFriendId: map['userToFriendId'] as int,
      icon: map['icon'] as String,
      name: map['name'] as String,
      amount: parsedAmount,
    );
  }

  String toJson() => json.encode(toMap());

  factory FriendResponse.fromJson(String source) =>
      FriendResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<FriendResponse> friendResponseListFromJson(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed
        .map<FriendResponse>((json) => FriendResponse.fromMap(json))
        .toList();
  }
}
