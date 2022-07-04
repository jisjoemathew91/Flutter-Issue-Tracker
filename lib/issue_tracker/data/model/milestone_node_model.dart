import 'package:flutter_issue_tracker/issue_tracker/domain/entities/milestone_node.dart';

class MilestoneNodeModel {
  MilestoneNodeModel({
    this.id,
    this.number,
    this.title,
  });

  MilestoneNodeModel.fromJson(dynamic json) {
    id = json['id'] as String?;
    number = json['number'] as int?;
    title = json['title'] as String?;
  }

  String? id;
  int? number;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['number'] = number;
    map['title'] = title;
    return map;
  }

  MilestoneNode toEntity() => MilestoneNode(
        id: id,
        number: number,
        title: title,
      );
}
