import 'package:hive/hive.dart';
import 'package:der/entities/site/trial.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class OnSiteUser {
  @HiveField(0)
  int userId;

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
  DateTime tokenDateTime;

  @HiveField(7)
  String passwordDigit;

  @HiveField(8)
  List<OnSiteTrial> onSiteTrials;

  OnSiteUser(
      this.userId,
      this.userName,
      this.firstName,
      this.lastName,
      this.picture,
      this.token,
      this.tokenDateTime,
      this.passwordDigit,
      this.onSiteTrials);
}
