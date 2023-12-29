import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_to_member_data.g.dart';

@JsonSerializable(includeIfNull: false)
@HiveType(typeId: 6)
class UserToMemberData {
  @HiveField(0)
  final int memberId;

  @HiveField(1)
  final String memberName;

  @HiveField(2)
  final double amountOwedToUser;

  @HiveField(3)
  final double amountLentToUser;

  @HiveField(4)
  final double amountOwedInGroup;

  @HiveField(5)
  final double amountLentInGroup;

  UserToMemberData(
      {required this.memberId,
      required this.memberName,
      required this.amountOwedToUser,
      required this.amountLentToUser,
      required this.amountOwedInGroup,
      required this.amountLentInGroup});

  factory UserToMemberData.fromJson(Map<String, dynamic> json) =>
      _$UserToMemberDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserToMemberDataToJson(this);
}
