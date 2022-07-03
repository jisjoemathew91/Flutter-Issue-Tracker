import 'package:flutter_issue_tracker/issue_tracker/data/model/assignable_user_node_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/page_info_model.dart';

class AssignableUsers {
  AssignableUsers({
    this.pageInfo,
    this.nodes,
  });

  PageInfoModel? pageInfo;
  List<AssignableUserNodeModel>? nodes;
}
