import 'package:json_annotation/json_annotation.dart';
import 'package:der/entities/user.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  final String token;

  User user;

  Token(this.token, this.user);

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
