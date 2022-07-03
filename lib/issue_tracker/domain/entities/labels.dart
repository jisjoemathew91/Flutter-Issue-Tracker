import 'package:flutter_issue_tracker/issue_tracker/data/model/label_node_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/page_info_model.dart';

class Labels {
  Labels({
    this.pageInfo,
    this.totalCount,
    this.nodes,
  });

  PageInfoModel? pageInfo;
  int? totalCount;
  List<LabelNodeModel>? nodes;
}
