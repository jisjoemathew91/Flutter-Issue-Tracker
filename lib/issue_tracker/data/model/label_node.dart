class LabelNodeModel {
  LabelNodeModel({
    this.id,
    this.color,
    this.name,
  });

  LabelNodeModel.fromJson(dynamic json) {
    id = json['id'] as String?;
    color = json['color'] as String?;
    name = json['name'] as String?;
  }

  String? id;
  String? color;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['color'] = color;
    map['name'] = name;
    return map;
  }
}
