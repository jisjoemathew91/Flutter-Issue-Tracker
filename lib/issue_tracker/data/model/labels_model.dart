import 'package:flutter_issue_tracker/issue_tracker/data/model/label_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/page_info_model.dart';

class LabelsModel {
  LabelsModel({
    this.pageInfo,
    this.totalCount,
    this.nodes,
  });

  LabelsModel.fromJson(dynamic json) {
    pageInfo = json['pageInfo'] != null
        ? PageInfoModel.fromJson(json['pageInfo'])
        : null;
    totalCount = json['totalCount'] as int?;
    if (json['nodes'] != null) {
      nodes = [];
      json['nodes'].forEach((dynamic v) {
        nodes?.add(LabelNodeModel.fromJson(v));
      });
    }
  }

  PageInfoModel? pageInfo;
  int? totalCount;
  List<LabelNodeModel>? nodes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (pageInfo != null) {
      map['pageInfo'] = pageInfo?.toJson();
    }
    map['totalCount'] = totalCount;
    if (nodes != null) {
      map['nodes'] = nodes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
