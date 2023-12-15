import 'package:json_annotation/json_annotation.dart';
part 'group_data.g.dart';

@JsonSerializable(includeIfNull: false)
class GroupData {
  final int groupId;
  final String groupName;
  final Map<int, String> members;
  final double amountBorrowed;
  final double amountLent;
  final String type;
  final String category;

  GroupData({
    required this.groupId,
    required this.groupName,
    required this.members,
    required this.amountBorrowed,
    required this.amountLent,
    required this.type,
    required this.category,
  });

  factory GroupData.fromJson(Map<String, dynamic> json) =>
      _$GroupDataFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDataToJson(this);
}
