// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
    json['userName'] == null ? "" : json['userName'] as String,
    json['firstName'] as String,
    json['lastName'] as String,
    json['picture'] == null ? "" : json['picture'] as String,
    (json['trials'] == null ? [] : json['trials'] as List<dynamic>)
        .map((e) => Trial.fromJson(e as Map<String, dynamic>))
        .toList());

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userName': instance.userName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'picture': instance.lastName,
      'trials': instance.trials,
    };
