import 'package:flutter_issue_tracker/issue_tracker/data/model/milestone_node_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/page_info_model.dart';

class Milestones {
  Milestones({
    this.pageInfo,
    this.nodes,
  });

  PageInfoModel? pageInfo;
  List<MilestoneNodeModel>? nodes;
}
