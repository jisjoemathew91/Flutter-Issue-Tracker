import 'package:flutter_issue_tracker/issue_tracker/data/model/issue_node_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/page_info_model.dart';

class Issues {
  Issues({
    this.pageInfo,
    this.nodes,
  });

  PageInfoModel? pageInfo;
  List<IssueNodeModel>? nodes;
}
