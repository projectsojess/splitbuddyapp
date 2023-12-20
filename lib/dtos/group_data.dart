import 'package:json_annotation/json_annotation.dart';
import 'package:splitbuddy/dtos/user_to_member_data.dart';
part 'group_data.g.dart';

@JsonSerializable(includeIfNull: false)
class GroupData {
  final int groupId;
  final String groupName;
  final Map<int, String> members;
  final double amountBorrowed;
  final double amountLent;
  final String type;
  final List<UserToMemberData> memberData;
  final String category;

  GroupData({
    required this.groupId,
    required this.groupName,
    required this.members,
    required this.amountBorrowed,
    required this.amountLent,
    required this.type,
    required this.category,
    required this.memberData,
  });

  factory GroupData.fromJson(Map<String, dynamic> json) =>
      _$GroupDataFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDataToJson(this);
}
