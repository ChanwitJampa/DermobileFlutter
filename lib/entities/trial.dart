import 'package:json_annotation/json_annotation.dart';
import 'package:der/entities/plot.dart';
import 'package:der/entities/site/enum.dart';
part 'trial.g.dart';

@JsonSerializable()
class Trial {
  final String trialId;

  final String aliasName;

  final String trialActive;

  final String trialStatus;

  final int plotSettingAutoLockUpload;

  final int plotSettingAutoLockApproved;

  final int createDate;

  final int lastUpdate;

  List<Plot> plots;

  Trial(
      this.trialId,
      this.aliasName,
      this.trialActive,
      this.trialStatus,
      this.plotSettingAutoLockUpload,
      this.plotSettingAutoLockApproved,
      this.createDate,
      this.lastUpdate,
      this.plots);

  factory Trial.fromJson(Map<String, dynamic> json) => _$TrialFromJson(json);

  Map<String, dynamic> toJson() => _$TrialToJson(this);
}
