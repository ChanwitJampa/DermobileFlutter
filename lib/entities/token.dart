class Token {
  Token({
    required this.token,
  });
  late final String token;

  Token.fromJson(Map<String, dynamic> json) {
    token = json['data'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = token;
    return _data;
  }
}
