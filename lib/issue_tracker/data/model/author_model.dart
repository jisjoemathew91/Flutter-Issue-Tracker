import 'package:flutter_issue_tracker/issue_tracker/domain/entities/author.dart';

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

  Author toEntity() => Author(
        avatarUrl: avatarUrl,
        login: login,
      );
}
