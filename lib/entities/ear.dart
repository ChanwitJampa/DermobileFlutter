import 'package:json_annotation/json_annotation.dart';

part 'ear.g.dart';

@JsonSerializable()
class Ear {
  int cornId;

  String earImgPath;
  String earImgPathS;
  double derPercentA;
  double derPercentM;
  int imgPosX;
  int imgPosY;
  int imgWidth;
  int imgHeigh;
  String cornDetectType;
  String earProgress;
  DateTime lastUpdate;

  Ear(
      this.cornId,
      this.earImgPath,
      this.earImgPathS,
      this.derPercentA,
      this.derPercentM,
      this.imgPosX,
      this.imgPosY,
      this.imgWidth,
      this.imgHeigh,
      this.cornDetectType,
      this.earProgress,
      this.lastUpdate);

  factory Ear.fromJson(Map<String, dynamic> json) => _$EarFromJson(json);

  Map<String, dynamic> toJson() => _$EarToJson(this);
}
