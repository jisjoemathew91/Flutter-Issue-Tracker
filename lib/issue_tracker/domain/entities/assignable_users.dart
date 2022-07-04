import 'package:flutter_issue_tracker/issue_tracker/domain/entities/assignable_user_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/page_info.dart';

class AssignableUsers {
  AssignableUsers({
    this.pageInfo,
    this.nodes,
  });

  PageInfo? pageInfo;
  List<AssignableUserNode>? nodes;
}
