// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trial _$TrialFromJson(Map<String, dynamic> json) => Trial(
      json['trialId'] as String,
      json['aliasName'] == null ? "null" : json['aliasName'] as String,
      json['trialActive'] as String,
      json['trialStatus'] as String,
      json['plotSettingAutoLockUpload'] as int,
      json['plotSettingAutoLockApproved'] as int,
      json['createDate'] == null ? 0 : json['createDate'] as int,
      json['lastUpdate'] as int,
      (json['plots'] as List<dynamic>)
          .map((e) => Plot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrialToJson(Trial instance) => <String, dynamic>{
      'trialId': instance.trialId,
      'aliasName': instance.aliasName,
      'trialActive': instance.trialActive,
      'trialStatus': instance.trialStatus,
      'plotSettingAutoLockUpload': instance.plotSettingAutoLockUpload,
      'plotSettingAutoLockApproved': instance.plotSettingAutoLockApproved,
      'createDate': instance.createDate,
      'lastUpdate': instance.lastUpdate,
      'plots': instance.plots,
    };
