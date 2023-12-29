// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'friend_response.g.dart';

@JsonSerializable(includeIfNull: false)
@HiveType(typeId: 7)
class FriendResponse {
  @HiveField(0)
  final int userToFriendId;

  @HiveField(1)
  final int userId;

  @HiveField(2)
  final int friendId;

  @HiveField(3)
  final String icon;

  @HiveField(4)
  final String name;

  @HiveField(5)
  final double amountOwedToFriend;

  @HiveField(6)
  final double amountLentToFriend;

  FriendResponse(
      {required this.userToFriendId,
      required this.userId,
      required this.friendId,
      required this.icon,
      required this.name,
      required this.amountLentToFriend,
      required this.amountOwedToFriend});

  factory FriendResponse.fromJson(Map<String, dynamic> json) =>
      _$FriendResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FriendResponseToJson(this);
}
