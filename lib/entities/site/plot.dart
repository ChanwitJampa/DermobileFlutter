import 'package:hive/hive.dart';

import 'enum.dart';

part 'plot.g.dart';

@HiveType(typeId: 2)
class OnSitePlot {
  @HiveField(0)
  int plotId;

  @HiveField(1)
  String barcode;

  @HiveField(2)
  String pltId;

  @HiveField(3)
  int repNo;

  @HiveField(4)
  String abbrc;

  @HiveField(5)
  int entno;

  @HiveField(6)
  String notet;

  @HiveField(7)
  String plotImgPath;

  @HiveField(8)
  String plotImgPathS;

  @HiveField(9)
  String plotImgBoxPath;

  @HiveField(10)
  String plotImgBoxPathS;

  @HiveField(11)
  int uploadDate;

  @HiveField(12)
  int eartnA;

  @HiveField(13)
  int dlernA;

  @HiveField(14)
  double dlerpA;

  @HiveField(15)
  double drwapA;

  @HiveField(16)
  int eartnM;

  @HiveField(17)
  int dlernM;

  @HiveField(18)
  double dlerpM;

  @HiveField(19)
  double drwapM;

  @HiveField(20)
  int approveDate;

  @HiveField(21)
  String plotProgress;

  @HiveField(22)
  String plotStatus;

  @HiveField(23)
  String plotActive;

  OnSitePlot(
      this.plotId,
      this.barcode,
      this.pltId,
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
      this.plotActive);
}
