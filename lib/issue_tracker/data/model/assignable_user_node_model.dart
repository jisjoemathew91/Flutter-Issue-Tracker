import 'package:flutter_issue_tracker/issue_tracker/domain/entities/assignable_user_node.dart';

class AssignableUserNodeModel {
  AssignableUserNodeModel({
    this.id,
    this.avatarUrl,
    this.name,
    this.login,
  });

  AssignableUserNodeModel.fromJson(dynamic json) {
    id = json['id'] as String?;
    avatarUrl = json['avatarUrl'] as String?;
    name = json['name'] as String?;
    login = json['login'] as String?;
  }

  String? id;
  String? avatarUrl;
  String? name;
  String? login;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['avatarUrl'] = avatarUrl;
    map['name'] = name;
    map['login'] = login;
    return map;
  }

  AssignableUserNode toEntity() => AssignableUserNode(
        id: id,
        avatarUrl: avatarUrl,
        name: name,
        login: login,
      );
}
