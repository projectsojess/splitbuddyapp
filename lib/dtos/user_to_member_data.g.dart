// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_to_member_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToMemberData _$UserToMemberDataFromJson(Map<String, dynamic> json) =>
    UserToMemberData(
      memberId: json['memberId'] as int,
      memberName: json['memberName'] as String,
      amountOwedToUser: (json['amountOwedToUser'] as num).toDouble(),
      amountLentToUser: (json['amountLentToUser'] as num).toDouble(),
      amountOwedInGroup: (json['amountOwedInGroup'] as num).toDouble(),
      amountLentInGroup: (json['amountLentInGroup'] as num).toDouble(),
    );

Map<String, dynamic> _$UserToMemberDataToJson(UserToMemberData instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'memberName': instance.memberName,
      'amountOwedToUser': instance.amountOwedToUser,
      'amountLentToUser': instance.amountLentToUser,
      'amountOwedInGroup': instance.amountOwedInGroup,
      'amountLentInGroup': instance.amountLentInGroup,
    };
