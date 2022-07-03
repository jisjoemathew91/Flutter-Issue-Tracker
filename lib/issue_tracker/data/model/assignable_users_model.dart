import 'package:flutter_issue_tracker/issue_tracker/data/model/assignable_user_node_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/page_info_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/assignable_users.dart';

class AssignableUsersModel {
  AssignableUsersModel({
    this.pageInfo,
    this.nodes,
  });

  AssignableUsersModel.fromJson(dynamic json) {
    pageInfo = json['pageInfo'] != null
        ? PageInfoModel.fromJson(json['pageInfo'])
        : null;
    if (json['nodes'] != null) {
      nodes = [];
      json['nodes'].forEach((dynamic v) {
        nodes?.add(AssignableUserNodeModel.fromJson(v));
      });
    }
  }

  PageInfoModel? pageInfo;
  List<AssignableUserNodeModel>? nodes;

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

  AssignableUsers toEntity() => AssignableUsers(
    nodes: nodes,
    pageInfo: pageInfo,
  );
}
