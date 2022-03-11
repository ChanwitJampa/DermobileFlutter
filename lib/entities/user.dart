import 'package:json_annotation/json_annotation.dart';
import 'package:der/entities/trial.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String userName;

  String firstName;

  String lastName;

  String picture;

  List<Trial> trials;

  User(
    this.userName,
    this.firstName,
    this.lastName,
    this.picture,
    this.trials,
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
