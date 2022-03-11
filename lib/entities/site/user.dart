import 'package:der/entities/site/plot.dart';
import 'package:hive/hive.dart';
import 'package:der/entities/site/trial.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class OnSiteUser extends HiveObject {
  @HiveField(1)
  String userName;

  @HiveField(2)
  String firstName;

  @HiveField(3)
  String lastName;

  @HiveField(4)
  String picture;

  @HiveField(5)
  String token;

  @HiveField(6)
  int tokenDateTime;

  @HiveField(7)
  String passwordDigit;

  @HiveField(8)
  List<OnSiteTrial> onSiteTrials;

  @HiveField(9)
  List<OnSitePlot> unMatchPlots;

  @HiveField(10)
  String password;
  OnSiteUser(
      this.userName,
      this.firstName,
      this.lastName,
      this.picture,
      this.token,
      this.tokenDateTime,
      this.passwordDigit,
      this.onSiteTrials,
      this.unMatchPlots,
      this.password
      //
      );
}
