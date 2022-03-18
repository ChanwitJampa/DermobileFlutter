import 'package:hive/hive.dart';

import 'enum.dart';

part 'plot.g.dart';

@HiveType(typeId: 2)
class OnSitePlot extends HiveObject {
  @HiveField(0)
  int pltId;

  @HiveField(1)
  String barcode;

  @HiveField(2)
  int repNo;

  @HiveField(3)
  String abbrc;

  @HiveField(4)
  int entno;

  @HiveField(5)
  String notet;

  @HiveField(6)
  String plotImgPath;

  @HiveField(7)
  String plotImgPathS;

  @HiveField(8)
  String plotImgBoxPath;

  @HiveField(9)
  String plotImgBoxPathS;

  @HiveField(10)
  int uploadDate;

  @HiveField(11)
  int eartnA;

  @HiveField(12)
  int dlernA;

  @HiveField(13)
  double dlerpA;

  @HiveField(14)
  double drwapA;

  @HiveField(15)
  int eartnM;

  @HiveField(16)
  int dlernM;

  @HiveField(17)
  double dlerpM;

  @HiveField(18)
  double drwapM;

  @HiveField(20)
  int approveDate;

  @HiveField(21)
  String plotProgress;

  @HiveField(22)
  String plotStatus;

  @HiveField(23)
  String plotActive;

  @HiveField(24)
  int isUpload;

  OnSitePlot(
      this.pltId,
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
      this.isUpload);
}
