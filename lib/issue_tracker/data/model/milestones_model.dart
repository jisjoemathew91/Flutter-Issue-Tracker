import 'package:flutter_issue_tracker/issue_tracker/data/model/milestone_node_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/page_info_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/milestones.dart';

class MilestonesModel {
  MilestonesModel({
    this.pageInfo,
    this.nodes,
  });

  MilestonesModel.fromJson(dynamic json) {
    pageInfo = json['pageInfo'] != null
        ? PageInfoModel.fromJson(json['pageInfo'])
        : null;
    if (json['nodes'] != null) {
      nodes = [];
      json['nodes'].forEach((dynamic v) {
        nodes?.add(MilestoneNodeModel.fromJson(v));
      });
    }
  }

  PageInfoModel? pageInfo;
  List<MilestoneNodeModel>? nodes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (pageInfo != null) {
      map['pageInfo'] = pageInfo?.toJson();
    }
    if (nodes != null) {
      map['nodes'] = nodes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  Milestones toEntity() => Milestones(
        nodes: nodes
            ?.map(
              (n) => n.toEntity(),
            )
            .toList(),
        pageInfo: pageInfo?.toEntity(),
      );
}
