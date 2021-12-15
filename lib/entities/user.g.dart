// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['userId'] as int,
      json['firstName'] as String,
      json['lastName'] as String,
      json['picture'] as String,
      json['adminRole'] as String,
      json['createDate'] as int,
      json['lastAccess'] as int,
      json['userStatus'] as String,
      json['tokenDateTime'] as String,
      json['plotsForApproveBy'] as String,
      json['usertrials'] as String,
      json['countryadmins'] as String,
      (json['trials'] as List<dynamic>)
          .map((e) => Trial.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['plotsForUploadBy'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'picture': instance.picture,
      'adminRole': instance.adminRole,
      'createDate': instance.createDate,
      'lastAccess': instance.lastAccess,
      'userStatus': instance.userStatus,
      'tokenDateTime': instance.tokenDateTime,
      'plotsForApproveBy': instance.plotsForApproveBy,
      'usertrials': instance.usertrials,
      'countryadmins': instance.countryadmins,
      'trials': instance.trials,
      'plotsForUploadBy': instance.plotsForUploadBy,
    };
