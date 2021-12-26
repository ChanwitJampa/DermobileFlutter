// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plot _$PlotFromJson(Map<String, dynamic> json) => Plot(
      json['plotId'] == null ? 0 : json['plotId'] as int,
      json['barcode'] == null ? "null" : json['barcode'] as String,
      json['repNo'] == null ? 0 : json['repNo'] as int,
      json['abbrc'] == null ? "null" : json['abbrc'] as String,
      json['entno'] == null ? 0 : json['entno'] as int,
      json['notet'] == null ? "null" : json['notet'] as String,
      json['plotImgPath'] == null ? "null" : json['plotImgPath'] as String,
      json['plotImgPathS'] == null ? "null" : json['plotImgPathS'] as String,
      json['plotImgBoxPath'] == null
          ? "null"
          : json['plotImgBoxPath'] as String,
      json['plotImgBoxPathS'] == null
          ? "null"
          : json['plotImgBoxPathS'] as String,
      json['uploadDate'] == null ? 0 : json['uploadDate'] as int,
      json['eartnA'] == null ? 0 : json['eartnA'] as int,
      json['dlernA'] == null ? 0 : json['dlernA'] as int,
      (json['dlerpA'] == null ? 0 : json['dlerpA'] as num).toDouble(),
      (json['drwapA'] == null ? 0 : json['drwapA'] as num).toDouble(),
      json['eartnM'] == null ? 0 : json['eartnM'] as int,
      json['dlernM'] == null ? 0 : json['dlernM'] as int,
      (json['dlerpM'] == null ? 0 : json['dlerpM'] as num).toDouble(),
      (json['drwapM'] == null ? 0 : json['drwapM'] as num).toDouble(),
      json['approveDate'] == null ? 0 : json['approveDate'] as int,
      json['plotProgress'] == null ? "null" : json['plotProgress'] as String,
      json['plotStatus'] == null ? "null" : json['plotStatus'] as String,
      json['plotActive'] == null ? "null" : json['plotActive'] as String,
      json['lastUpdate'] == null ? 0 : json['lastUpdate'] as int,
      json['ears'] == null
          ? []
          : (json['ears'] as List<dynamic>)
              .map((e) => Ear.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$PlotToJson(Plot instance) => <String, dynamic>{
      'plotId': instance.plotId,
      'barcode': instance.barcode,
      'repNo': instance.repNo,
      'abbrc': instance.abbrc,
      'entno': instance.entno,
      'notet': instance.notet,
      'plotImgPath': instance.plotImgPath,
      'plotImgPathS': instance.plotImgPathS,
      'plotImgBoxPath': instance.plotImgBoxPath,
      'plotImgBoxPathS': instance.plotImgBoxPathS,
      'uploadDate': instance.uploadDate,
      'eartnA': instance.eartnA,
      'dlernA': instance.dlernA,
      'dlerpA': instance.dlerpA,
      'drwapA': instance.drwapA,
      'eartnM': instance.eartnM,
      'dlernM': instance.dlernM,
      'dlerpM': instance.dlerpM,
      'drwapM': instance.drwapM,
      'approveDate': instance.approveDate,
      'plotProgress': instance.plotProgress,
      'plotStatus': instance.plotStatus,
      'plotActive': instance.plotActive,
      'lastUpdate': instance.lastUpdate,
      'ears': instance.ears,
    };
