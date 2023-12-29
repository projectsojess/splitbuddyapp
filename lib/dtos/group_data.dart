import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:splitbuddy/dtos/user_to_member_data.dart';
part 'group_data.g.dart';

@JsonSerializable(includeIfNull: false)
@HiveType(typeId: 5)
class GroupData {
  @HiveField(0)
  final int groupId;

  @HiveField(1)
  final String groupName;

  @HiveField(2)
  final Map<int, String> members;

  @HiveField(3)
  final double amountBorrowed;

  @HiveField(4)
  final double amountLent;

  @HiveField(5)
  final String type;

  @HiveField(6)
  final List<UserToMemberData> memberData;

  @HiveField(7)
  final String category;

  @HiveField(8)
  final DateTime createdDate;

  GroupData(
      {required this.groupId,
      required this.groupName,
      required this.members,
      required this.amountBorrowed,
      required this.amountLent,
      required this.type,
      required this.category,
      required this.memberData,
      required this.createdDate});

  factory GroupData.fromJson(Map<String, dynamic> json) =>
      _$GroupDataFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDataToJson(this);
}
