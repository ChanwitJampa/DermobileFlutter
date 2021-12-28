import 'package:hive/hive.dart';
import 'package:der/entities/site/plot.dart';
import 'package:der/entities/trial.dart';

import 'enum.dart';
part 'trial.g.dart';

@HiveType(typeId: 1)
class OnSiteTrial extends HiveObject {
  @HiveField(0)
  String trialId;

  @HiveField(1)
  String aliasName;

  @HiveField(2)
  String trialActive;

  @HiveField(3)
  String trialStatus;

  @HiveField(4)
  int createDate;

  @HiveField(5)
  int lastUpdate;

  @HiveField(6)
  List<OnSitePlot> onSitePlots;

  //lastModifyDateOnSite

  OnSiteTrial(this.trialId, this.aliasName, this.trialActive, this.trialStatus,
      this.createDate, this.lastUpdate, this.onSitePlots);
}
