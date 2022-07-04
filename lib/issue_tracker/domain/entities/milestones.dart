import 'package:flutter_issue_tracker/issue_tracker/domain/entities/milestone_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/page_info.dart';

class Milestones {
  Milestones({
    this.pageInfo,
    this.nodes,
  });

  PageInfo? pageInfo;
  List<MilestoneNode>? nodes;
}
