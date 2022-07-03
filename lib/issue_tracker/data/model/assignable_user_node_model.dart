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
}
