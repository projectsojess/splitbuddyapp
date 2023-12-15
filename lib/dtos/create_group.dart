import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'create_group.g.dart';

@JsonSerializable(includeIfNull: false)
class CreateGroup {
  String groupName;
  String category;
  String type;
  List<int> participants;
  CreateGroup(
      {required this.groupName,
      required this.category,
      required this.participants,
      required this.type});

  factory CreateGroup.fromJson(Map<String, dynamic> json) =>
      _$CreateGroupFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGroupToJson(this);
}
