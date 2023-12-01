// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FriendResponse {
  final int userToFriendId;
  final int userId;
  final int friendId;
  final String icon;
  final String name;
  final double amount;

  FriendResponse(
      {required this.userToFriendId,
      required this.userId,
      required this.friendId,
      required this.icon,
      required this.name,
      required this.amount});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userToFriendId': userToFriendId,
      'userId': userId,
      'friendId': friendId,
      'icon': icon,
      'name': name,
      'amount': amount,
    };
  }

  factory FriendResponse.fromMap(Map<String, dynamic> map) {
    dynamic amountValue = double.tryParse(map['amount']) ?? 0.0;
    double parsedAmount =
        amountValue is int ? amountValue.toDouble() : amountValue as double;
    return FriendResponse(
      userToFriendId: map['userToFriendId'] as int,
      userId: map['userId'] as int,
      friendId: map['friendId'] as int,
      icon: map['icon'] as String,
      name: map['name'] as String,
      amount: parsedAmount,
    );
  }

  String toJson() => json.encode(toMap());

  factory FriendResponse.fromJson(String source) =>
      FriendResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<FriendResponse> friendResponseListFromJson(String jsonString) {
    final parsed =
        json.decode(jsonString)['friends'].cast<Map<String, dynamic>>();
    return parsed
        .map<FriendResponse>((json) => FriendResponse.fromMap(json))
        .toList();
  }
}
