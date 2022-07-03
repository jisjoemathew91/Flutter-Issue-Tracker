import 'package:flutter_issue_tracker/issue_tracker/data/model/issue_node_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/page_info_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issues.dart';

class IssuesModel {
  IssuesModel({
    this.pageInfo,
    this.nodes,
  });

  IssuesModel.fromJson(dynamic json) {
    pageInfo = json['pageInfo'] != null
        ? PageInfoModel.fromJson(json['pageInfo'])
        : null;
    if (json['nodes'] != null) {
      nodes = [];
      json['nodes'].forEach((dynamic v) {
        nodes?.add(IssueNodeModel.fromJson(v));
      });
    }
  }

  PageInfoModel? pageInfo;
  List<IssueNodeModel>? nodes;

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

  Issues toEntity() => Issues(
        nodes: nodes,
        pageInfo: pageInfo,
      );
}
