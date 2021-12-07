// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ear.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ear _$EarFromJson(Map<String, dynamic> json) => Ear(
      json['cornId'] as int,
      json['earImgPath'] as String,
      json['earImgPathS'] as String,
      (json['derPercentA'] as num).toDouble(),
      (json['derPercentM'] as num).toDouble(),
      json['imgPosX'] as int,
      json['imgPosY'] as int,
      json['imgWidth'] as int,
      json['imgHeigh'] as int,
      json['cornDetectType'] as String,
      json['earProgress'] as String,
      DateTime.parse(json['lastUpdate'] as String),
    );

Map<String, dynamic> _$EarToJson(Ear instance) => <String, dynamic>{
      'cornId': instance.cornId,
      'earImgPath': instance.earImgPath,
      'earImgPathS': instance.earImgPathS,
      'derPercentA': instance.derPercentA,
      'derPercentM': instance.derPercentM,
      'imgPosX': instance.imgPosX,
      'imgPosY': instance.imgPosY,
      'imgWidth': instance.imgWidth,
      'imgHeigh': instance.imgHeigh,
      'cornDetectType': instance.cornDetectType,
      'earProgress': instance.earProgress,
      'lastUpdate': instance.lastUpdate.toIso8601String(),
    };
