class AuthorModel {
  AuthorModel({
    this.avatarUrl,
    this.login,
  });

  AuthorModel.fromJson(dynamic json) {
    avatarUrl = json['avatarUrl'] as String?;
    login = json['login'] as String?;
  }

  String? avatarUrl;
  String? login;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avatarUrl'] = avatarUrl;
    map['login'] = login;
    return map;
  }
}
