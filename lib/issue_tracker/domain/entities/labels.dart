import 'package:flutter_issue_tracker/issue_tracker/domain/entities/label_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/page_info.dart';

class Labels {
  Labels({
    this.pageInfo,
    this.totalCount,
    this.nodes,
  });

  PageInfo? pageInfo;
  int? totalCount;
  List<LabelNode>? nodes;
}
