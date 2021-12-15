import 'package:json_annotation/json_annotation.dart';
import 'package:der/entities/trial.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int userId;
  final String? firstName;
  final String? lastName;
  final String? picture;
  final String? adminRole;
  final int? createDate;
  final int? lastAccess;
  final String? userStatus;
  final String? tokenDateTime;
  final String? plotsForApproveBy;
  final String? usertrials;
  final String? countryadmins;
  final List<Trial>? trials;
  final String? plotsForUploadBy;

  User(
      this.userId,
      this.firstName,
      this.lastName,
      this.picture,
      this.adminRole,
      this.createDate,
      this.lastAccess,
      this.userStatus,
      this.tokenDateTime,
      this.plotsForApproveBy,
      this.usertrials,
      this.countryadmins,
      this.trials,
      this.plotsForUploadBy);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
