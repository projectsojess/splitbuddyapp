import 'package:json_annotation/json_annotation.dart';

part 'user_to_member_data.g.dart';

@JsonSerializable(includeIfNull: false)
class UserToMemberData {
  final int memberId;
  final String memberName;
  final double amountOwedToUser;
  final double amountLentToUser;
  final double amountOwedInGroup;
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
