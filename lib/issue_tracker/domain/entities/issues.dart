import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issue_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/page_info.dart';

class Issues {
  Issues({
    this.pageInfo,
    this.nodes,
  });

  PageInfo? pageInfo;
  List<IssueNode>? nodes;
}
