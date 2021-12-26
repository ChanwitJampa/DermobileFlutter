import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:der/entities/ear.dart';

part 'plot.g.dart';

@JsonSerializable()
class Plot {
  final int plotId;

  String barcode;
  int repNo;
  String abbrc;
  int entno;
  String notet;
  String plotImgPath;
  String plotImgPathS;
  String plotImgBoxPath;
  String plotImgBoxPathS;
  int uploadDate;
  int eartnA;
  int dlernA;
  double dlerpA;
  double drwapA;
  int eartnM;
  int dlernM;
  double dlerpM;
  double drwapM;
  int approveDate;
  String plotProgress;
  String plotStatus;
  String plotActive;
  int lastUpdate;

  Plot(
      this.plotId,
      this.barcode,
      this.repNo,
      this.abbrc,
      this.entno,
      this.notet,
      this.plotImgPath,
      this.plotImgPathS,
      this.plotImgBoxPath,
      this.plotImgBoxPathS,
      this.uploadDate,
      this.eartnA,
      this.dlernA,
      this.dlerpA,
      this.drwapA,
      this.eartnM,
      this.dlernM,
      this.dlerpM,
      this.drwapM,
      this.approveDate,
      this.plotProgress,
      this.plotStatus,
      this.plotActive,
      this.lastUpdate,
      this.ears);

  List<Ear> ears;

  factory Plot.fromJson(Map<String, dynamic> json) => _$PlotFromJson(json);

  Map<String, dynamic> toJson() => _$PlotToJson(this);
}
