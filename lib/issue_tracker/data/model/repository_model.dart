import 'package:flutter_issue_tracker/issue_tracker/data/model/issue_node_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/issues_model.dart';

class RepositoryModel {
  RepositoryModel({
    this.issue,
    this.issues,
  });

  RepositoryModel.fromJson(dynamic json) {
    issue =
        json['issue'] != null ? IssueNodeModel.fromJson(json['issue']) : null;
    issues =
        json['issues'] != null ? IssuesModel.fromJson(json['issues']) : null;
  }

  IssueNodeModel? issue;
  IssuesModel? issues;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (issue != null) {
      map['issue'] = issue?.toJson();
    }
    if (issues != null) {
      map['issues'] = issues?.toJson();
    }
    return map;
  }
}
