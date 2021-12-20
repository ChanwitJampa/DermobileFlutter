import 'package:hive/hive.dart';
import 'package:der/entities/site/trial.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class OnSiteUser {
  @HiveField(0)
  String userName;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  String picture;

  @HiveField(4)
  List<OnSiteTrial> onSiteTrials;

  OnSiteUser(this.userName, this.firstName, this.lastName, this.picture,
      this.onSiteTrials);
}
