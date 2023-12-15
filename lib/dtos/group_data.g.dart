// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupData _$GroupDataFromJson(Map<String, dynamic> json) => GroupData(
      groupId: json['groupId'] as int,
      groupName: json['groupName'] as String,
      members: (json['members'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as String),
      ),
      amountBorrowed: (json['amountBorrowed'] as num).toDouble(),
      amountLent: (json['amountLent'] as num).toDouble(),
      type: json['type'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$GroupDataToJson(GroupData instance) => <String, dynamic>{
      'groupId': instance.groupId,
      'groupName': instance.groupName,
      'members': instance.members.map((k, e) => MapEntry(k.toString(), e)),
      'amountBorrowed': instance.amountBorrowed,
      'amountLent': instance.amountLent,
      'type': instance.type,
      'category': instance.category,
    };
