// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGroup _$CreateGroupFromJson(Map<String, dynamic> json) => CreateGroup(
      groupName: json['groupName'] as String,
      category: json['category'] as String,
      participants:
          (json['participants'] as List<dynamic>).map((e) => e as int).toList(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$CreateGroupToJson(CreateGroup instance) =>
    <String, dynamic>{
      'groupName': instance.groupName,
      'category': instance.category,
      'type': instance.type,
      'participants': instance.participants,
    };
